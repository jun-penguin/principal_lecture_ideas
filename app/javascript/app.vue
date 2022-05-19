<template>
  <v-app>
    <Header />
    <p v-if="this.$route.path =='/'">
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
import Header from "./components/Header.vue";
import Footer from "./components/Footer.vue";
import Message from "./components/Message.vue";
import { mapState } from "vuex";

export default {
  name: "App",
  components: {
    Header,
    Footer,
    Message
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