<template>
  <v-app>
    <Header></Header>
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
};
</script>

<style scoped>
</style>