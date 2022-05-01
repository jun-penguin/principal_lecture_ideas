<template>
  <v-app>
    <Header></Header>
    <p>
      こんにちは、<span class="name">{{ name }}</span
      >さん
    </p>
    <p class="email">現在、 {{ email }} でログイン中です</p>
    <router-view></router-view>
    <v-footer>
      <Footer></Footer>
    </v-footer>
  </v-app>
</template>  

<script>
import Header from "./components/Header.vue";
import Footer from "./components/Footer.vue";

export default {
  name: "App",
  components: {
    Header,
    Footer,
  },
  data() {
    return {
      name: window.localStorage.getItem("name"),
      email: window.localStorage.getItem("uid"),
    };
  },
};
</script>

<style scoped>
</style>