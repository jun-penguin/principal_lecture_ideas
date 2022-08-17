import Vue from "vue";
import axios from "../plugins/axios.js";
import Vuetify from "vuetify";
import colors from "vuetify/lib/util/colors";
import router from "../router/index.js";
import App from "../app.vue";
import store from "../store/store.js";
import dayjs from "dayjs"; 
import "dayjs/locale/ja";
import "vuetify/dist/vuetify.min.css";
import "@mdi/font/css/materialdesignicons.css";

Vue.use(Vuetify);
const vuetify = new Vuetify({
  theme: {
    themes: {
      light: {
        secondary: colors.grey.darken1,
        accent: colors.shades.black,
        white: colors.shades.white,
        background: colors.brown.lighten5,
      },
      dark: {
        primary: colors.blue.lighten3,
        background: colors.indigo.base,
      },
    },
  },
});
Vue.prototype.$axios = axios;

// 日付の日本語表示
dayjs.locale("ja");

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    colors,
    router,
    store,
    vuetify,
    render: (h) => h(App),
  }).$mount();
  document.body.appendChild(app.$el);
});
