<template>
  <div>
    <v-app-bar color="gray accent-4" dark>
      <!-- サイトタイトル -->
      <v-toolbar-title>Principal_lecture_Ideas</v-toolbar-title>

      <v-spacer></v-spacer>

      <!-- 検索フォーム -->
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

      <!-- いいねした講話リンク -->
      <v-btn v-if="loggedIn" rounded text large color="primary" class="mr-2"
        ><router-link to="/favorite">いいねした講話</router-link></v-btn
      >
      <!-- マイページメニュー -->
      <v-menu v-if="loggedIn" offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn color="primary" dark v-bind="attrs" v-on="on">
            マイページメニュー
          </v-btn>
        </template>
        <v-list>
          <template v-for="(item, index) in items">
            <v-list-item
              :key="index"
              :to="item.link"
              v-on:click="triggerClick(item.action)"
            >
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item>
          </template>
        </v-list>
      </v-menu>
      <!-- 新規ユーザー登録 -->
      <Signup v-if="!loggedIn" @redirectToHome="redirectToHome" />

      <!-- ログインボタン -->
      <Login v-if="!loggedIn" @redirectToHome="redirectToHome" />
    </v-app-bar>
  </div>
</template>

<script>
import Signup from "./Signup.vue";
import Login from "./Login.vue";
import { mapState } from "vuex";

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
      isloggedIn: "false",
      items: [
        // { title: "投稿した講話",
        //   link: },
        { title: "講話の投稿", link: "/create", action: "" },
        // { title: "プロフィール編集", link: /profile/edit },
        { title: "ログアウト", link: "", action: "logOut" },
      ],
    };
  },
  computed: {
    ...mapState("auth", {
      loggedIn: (state) => state.loggedIn,
    }),
  },
  methods: {
    logOut() {
      this.$store.dispatch("auth/logOut");
      this.redirectToHome();
    },
    triggerClick(action) {
      if (action === "logOut") {
        this.logOut();
        // } else if (action === action2) {
        //   anyAction2();
      }
    },
    redirectToHome() {
      this.$router.push({ name: "PostIndex" });
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
    },
  },
};
</script>

<style scoped>
</style>
