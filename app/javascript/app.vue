<template>
  <v-app>
    <Header></Header>
    <p>
      こんにちは、<span class="name">{{ name }}</span
      >さん
    </p>
    <router-view></router-view>
    <v-footer>
      <Footer></Footer>
    </v-footer>
  </v-app>
</template>  

<script>
import Header from "./components/Header.vue";
import Footer from "./components/Footer.vue";
import { mapState } from "vuex";

export default {
  name: "App",
  components: {
    Header,
    Footer,
  },
  
computed: {
  ...mapState('auth', 
  {
    name: state => state.name
  })  
}
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