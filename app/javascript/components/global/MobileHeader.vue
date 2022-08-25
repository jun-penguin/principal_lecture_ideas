<template>
  <div>
    <v-app-bar color="gray accent-4" dark>
      <!-- サイトロゴ -->
      <v-img
        class="mx-2"
        v-bind:src="require('../../../assets/images/logo.png')"
        max-height="45"
        max-width="115"
        contain
        @click="$router.push('/')"
        style="cursor: pointer"
      ></v-img>

      <v-spacer></v-spacer>
      <!-- 検索用ボタン -->
      <v-btn  @click="dialogBtn" icon small :class="{ 'pr-3': loggedIn}">
      <v-icon  
        >mdi-file-search-outline</v-icon
      ></v-btn>

      <!-- 検索ダイアログ -->
      <v-dialog v-model="dialog" max-width="400">
        <v-card>
          <search class="mx-3" @closeDialog="dialogBtn" />
        </v-card>
      </v-dialog>
      <!-- 参考にした講話リンク  -->
      <router-link
        v-if="loggedIn"
        to="/favorites"
        class="pr-3"
        ><v-btn icon small><v-icon>mdi-heart-outline</v-icon></v-btn></router-link
      >
      <!-- マイページメニュー -->
      <v-menu v-if="loggedIn" offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-icon v-bind="attrs" v-on="on"
            >mdi-dots-horizontal-circle-outline</v-icon
          >
        </template>
        <v-list>
          <template v-for="(item, index) in items">
            <v-list-item
              :key="index"
              :to="item.link"
              v-on:click="triggerClick(item.action)"
            >
              <v-list-item-icon>
                <v-icon v-text="item.icon"></v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title v-text="item.title"></v-list-item-title>
              </v-list-item-content>
              <!-- <v-list-item-title>{{ item.title }}</v-list-item-title> -->
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
import Signup from "../parts/Signup.vue";
import Login from "../parts/Login.vue";
import Search from "../parts/Search.vue";
import { mapState } from "vuex";

export default {
  name: "Header",
  components: {
    Signup,
    Login,
    Search,
  },
  data() {
    return {
      dialog: false,
      items: [
        {
          icon: "mdi-file-edit-outline",
          title: "投稿した講話の管理",
          link: "/postings",
          action: "",
        },
        {
          icon: "mdi-note-plus",
          title: "講話の投稿",
          link: "/create",
          action: "",
        },
        {
          icon: "mdi-account-edit",
          title: "プロフィールの確認・編集",
          link: "/myProfile",
        },
        {
          icon: "mdi-account-cancel-outline",
          title: "ログアウト",
          link: "",
          action: "logOut",
        },
      ],
    };
  },
  computed: {
    ...mapState("auth", {
      loggedIn: (state) => state.loggedIn,
    }),
  },
  methods: {
    dialogBtn() {
      this.dialog == true ? (this.dialog = false) : (this.dialog = true);
    },
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
