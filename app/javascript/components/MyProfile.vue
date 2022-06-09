<template>
  <v-container>
    <h1>ユーザープロフィール</h1>
    <v-divider></v-divider>
    <h2>ユーザー名</h2>
    {{ name }}
    <h2>メールアドレス</h2>
    {{ headers.uid }}
    <h2>一言自己紹介</h2>
    <p v-if="profile.self_introduction !== null && profile.self_introduction !== '' ">
      {{ profile.self_introduction }}
    </p>
    <p v-else>自己紹介が設定されていません。</p>
    <h2>ステータス</h2>
    {{ profile.status_ja }}
    <h2>都道府県</h2>
    {{ profile.prefecture }}
    <div class="pt-3">
      <v-btn depressed color="success">
        <router-link
          style="text-decoration: none; color: inherit"
          :to="{ path: `/myProfile/edit` }"
          class="btn"
          >編集する</router-link
        >
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
export default {
  name: "MyProfile",
  data: function () {
    return {
      profile: [],
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
      name: (state) => state.name,
    }),
  },
  mounted: function () {
    this.fetchMyProfile();
  },
  methods: {
    fetchMyProfile: function () {
      console.log("プロフィールデータの取得開始");
      this.$axios
        .get("/api/profiles/mypage", {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then(
          (response) => {
            this.profile = response.data;
            console.log("ここでプロフィール情報の決定");
          },
          (error) => {
            console.log(error);
          }
        );
    },
  },
};
</script>

<style scoped>
</style>