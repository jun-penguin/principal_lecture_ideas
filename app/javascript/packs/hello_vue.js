import Vue from "vue";

//import { ValidationProvider, extend, localize } from "vee-validate";
//import { required } from "vee-validate/dist/rules";
//import ja from "vee-validate/dist/locale/ja.json";
import Vuetify from "vuetify";
import router from "../router/index.js";
import App from "../app.vue";
import store from "../store/store.js";


import "vuetify/dist/vuetify.min.css";
import "@mdi/font/css/materialdesignicons.css";

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    router,
    store,
    vuetify,
    render: (h) => h(App),
  }).$mount();
  document.body.appendChild(app.$el);
});
