<template>
  <div>
    <v-app-bar color="gray accent-4" dark>
      <v-toolbar-title>Proncipal_lecture_Ideas</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-text-field
        v-model="message"
        label="検索したいワードを入力してください"
        type="text"
      >
        <template v-slot:append-outer>
          <v-btn color="primary">検索</v-btn>
        </template>
      </v-text-field>

      <v-spacer></v-spacer>

      <v-btn rounded text large color="primary" class="mr-2"
        ><router-link to="/create">講話の投稿</router-link></v-btn
      >
      <v-btn @click="logOut" rounded text large color="primary" class="mr-2"
        >ログアウト</v-btn
      >

      <Signup @redirectToHome="redirectToHome" />
      <Login @redirectToHome="redirectToHome" />
    </v-app-bar>
  </div>
</template>

<script>
import Signup from "./Signup.vue";
import Login from "./Login.vue";
// import axios from "axios";
export default {
  name: "Header",
  components: {
    Signup,
    Login,
  },
  data() {
    return {
      message: "",
    };
  },
  methods: {
    logOut() {
      this.$store.dispatch("auth/logOut");
    },
    // async logout() {
    //   try {
    //     const res = await axios.delete("http://localhost:3000/auth/sign_out", {
    //       headers: {
    //         uid: this.email,
    //         "access-token": window.localStorage.getItem("access-token"),
    //         client: window.localStorage.getItem("client"),
    //       },
    //     });
    //     console.log("ログアウトしました");
    //     window.localStorage.removeItem("access-token");
    //     window.localStorage.removeItem("client");
    //     window.localStorage.removeItem("uid");
    //     window.localStorage.removeItem("name");
    //     this.$router.push({ name: 'PostIndex' });
    //     return res;
    //   } catch (error) {
    //     console.log({ error });
    //   }
    // },
    redirectToHome() {
      this.$router.push({ name: "PostIndex" });
    },
  },
};
</script>

<style scoped>
</style>
