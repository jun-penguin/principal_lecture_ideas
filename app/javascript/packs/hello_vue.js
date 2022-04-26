import Vue from "vue";
import Vuetify from "vuetify"; // 追加
import router from "../router/index.js";
import App from "../app.vue";

import "vuetify/dist/vuetify.min.css"; // 追加
import '@mdi/font/css/materialdesignicons.css' //icon



Vue.use(Vuetify); // 追加
const vuetify = new Vuetify(); // 追加

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    router,
    vuetify, // 追加
    render: h => h(App)
  }).$mount();
  document.body.appendChild(app.$el);
});