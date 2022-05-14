import axios from "axios";

// ヘッダー情報とログイン状況を管理
const state = {
  headers: {},
  name: "",
  loggedIn: false,
};

const mutations = {
  // レスポンスヘッダーのデータを保存しstateに反映
  logIn(state, { headers, name }) {
    state.headers = {
      "access-token": headers["access-token"],
      client: headers["client"],
      uid: headers["uid"],
    };
    state.name = name;
  },
  // ログインの有無を変更
  setLoggedIn(state, bool) {
    state.loggedIn = bool;
  },

  //サインアウトしたらヘッダを空にしておく。
  signOut(state) {
    state.headers = {};
    state.name = "";
  },

  //ユーザーネームの変更
  updateName(state, { name }) {
    state.name = name;
  },
};

const actions = {
  // ログイン：emailとpasswordをAPIに投げる
  logIn(context, { email, password }) {
    axios
      .post("http://localhost:3000/auth/sign_in", {
        email: email,
        password: password,
      })
      // APIからレスポンスヘッダーを受け取り"logIn"に渡す
      .then(function (response) {
        context.commit(
          "logIn",
          {
            headers: response.headers,
            name: response.data.data.name,
          },
          // setLoggedInを呼び出しtrueを渡す
          context.commit("setLoggedIn", true)
        );
      });
  },
  // 新規登録：新規登録に必要なデータをAPIに投げる
  signUp(context, { name, email, password, password_confirmation }) {
    axios
      .post("http://localhost:3000/auth", {
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
      })
      // APIからレスポンスヘッダーを受け取り"logIn"に渡す
      .then(function (response) {
        
        context.commit("logIn", {
          headers: response.headers,
          name: response.data.data.name,
        });
        context.commit("setLoggedIn", true);
      });
  },
  logOut(context) {
    axios
      // ヘッダ情報を呼び出してDeleteリクに投げる
      .delete("http://localhost:3000/auth/sign_out", {
        headers: context.state.headers,
      })
      .then(function () {
        // storeのヘッダー情報を空にする
        context.commit("signOut");
        // setLoggedInを呼び出しfalseを渡す
        context.commit("setLoggedIn", false);
      });
  },
  // プロフィール編集: データをAPIに投げる
  updateProfile(context, { name, self_introduction, status, prefecture }) {
    axios
      .put(
        "http://localhost:3000/auth",
        {
          name: name,
          self_introduction: self_introduction,
          status: status,
          prefecture: prefecture,
        },
        {
          headers: context.state.headers 
        }
      )
      // APIからレスポンスヘッダーを受け取りレスポンス内のnameを"updateName"に渡す
      .then(function (response) {
        console.log(response);
        context.commit("updateName", {
          name: response.data.data.name,
        });
      });
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
