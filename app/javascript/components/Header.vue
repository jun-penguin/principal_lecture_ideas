<template>
  <div>
    <v-app-bar color="gray accent-4" dark>
      <!-- サイトロゴ -->
      <v-img
        class="mx-2 pr-3"
        v-bind:src="require('../../assets/images/logo.png')"
        max-height="50"
        max-width="60"
        contain
        @click="$router.push('/')"
        style="cursor: pointer"
      ></v-img>
      <!-- サイトタイトル -->
      <v-toolbar-title @click="$router.push('/')" style="cursor: pointer"
        >校長講話アイディアボックス</v-toolbar-title
      >

      <v-spacer></v-spacer>

      <!-- 検索フォーム -->
      <Search />

      <v-spacer></v-spacer>

      <!-- 参考にした講話リンク  -->
      <v-btn v-if="loggedIn" rounded text large color="primary" class="mr-2"
        ><router-link to="/mylikes" style="text-decoration: none">参考にした講話</router-link></v-btn
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
      <Signup v-if="!loggedIn" />

      <!-- ログインボタン -->
      <Login v-if="!loggedIn" />
    </v-app-bar>
  </div>
</template>

<script>
import Signup from "./Signup.vue";
import Login from "./Login.vue";
import Search from "./Search.vue";
import { mapState } from "vuex";

// import axios from "axios";
export default {
  name: "Header",
  components: {
    Signup,
    Login,
    Search,
  },
  data() {
    return {
      items: [
        { title: "投稿した講話の管理", link: "/postings", action: "" },
        { title: "講話の投稿", link: "/create", action: "" },
        { title: "プロフィールの確認・編集", link: "/myProfile" },
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
      }
    },
    redirectToHome() {
      this.$router.push({ name: "PostIndex" });
    },
  },
};
</script>

<style scoped>
</style>
