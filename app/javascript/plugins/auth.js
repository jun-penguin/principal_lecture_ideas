import axios from "axios";

const state = {
  //ヘッダの入れ物を用意。
  headers: {},
  name: "",
};

const mutations = {
  //サインイン時のレスポンスヘッダから情報を抜き出して保存しておく。
  logIn(state, { headers, name }) {
    state.headers = {
      "access-token": headers["access-token"],
      client: headers["client"],
      uid: headers["uid"],
    };
    state.name = name;
  },

  //サインアウトしたらヘッダを空にしておく。
  signOut(state) {
    state.headers = {};
    state.name = "";
  },
};

const actions = {
  //paramsはemailなどのユーザー情報が入っていると思って下さい。
  //（paramsへの情報の入れ方は今回割愛。）
  logIn(context, { email, password }) {
    axios
      .post("http://localhost:3000/auth/sign_in", {
        email: email,
        password: password,
      })
      .then(function (response) {
        //ここでレスポンスヘッダを受け取る。
        context.commit("logIn", {
          headers: response.headers,
          name: response.data.data.name,
        });
      });
  },
  signUp(context, { name, email, password, password_confirmation }) {
    axios
      .post("http://localhost:3000/auth", {
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      })
      .then(function (response) {
        //ここでレスポンスヘッダを受け取る。
        context.commit("logIn", {
          headers: response.headers,
          name: response.data.data.name,
        });
      });
  },
  logOut(context) {
    axios
      //ここでヘッダ情報を呼び出してDELETEリクエストに含める
      .delete("http://localhost:3000/auth/sign_out", {
        headers: context.state.headers,
      })
      .then(function () {
        context.commit("signOut");
      });
  },
};

export default  {
  namespaced: true,
  state,
  mutations,
  actions,
};
