<template>
  <v-app  :style="{ background: $vuetify.theme.themes.light.background }">
    <Header />
    <p class="font-weight-bold" v-if="this.$route.path == '/' && loggedIn">
      こんにちは、<span class="name">{{ name }}</span
      >さん
    </p>
    <Message />
    <div class="pg-16">
      <router-view></router-view>
    </div>
    <Footer />
  </v-app>
</template>  

<script>
import Header from "./components/global/Header.vue";
import Footer from "./components/global/Footer.vue";
import Message from "./components/parts/Message.vue";
import { mapState } from "vuex";

export default {
  name: "App",
  components: {
    Header,
    Footer,
    Message,
  },

  computed: {
    ...mapState("auth", {
      name: (state) => state.name,
      loggedIn: (state) => state.loggedIn,
    }),
  },
  // data() {
  //   return {
  //     name: window.localStorage.getItem("name"),
  //     email: window.localStorage.getItem("uid"),
  //   };
  // },
};
</script>

<style scoped>
</style>