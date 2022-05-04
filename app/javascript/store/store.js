import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
import auth from "../plugins/auth.js";


Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    auth,
  },
  //strict: true, //厳格モード。デプロイ時は消す
  plugins: [
    createPersistedState({
      key: "principal_lecture_ideas",
      storage: window.sessionStorage,
    }),
  ],
});

export default store;
