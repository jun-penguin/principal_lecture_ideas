<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">ユーザープロフィール</p>
    <v-divider></v-divider>
    <p class="text-h5 pt-3 font-weight-bold">ユーザー名</p>
    {{ profile.name }}
    <p class="text-h5 pt-3 font-weight-bold">メールアドレス</p>
    {{ headers.uid }}
    <p class="text-h5 pt-3 font-weight-bold">一言自己紹介</p>
    <p
      v-if="
        profile.self_introduction !== null && profile.self_introduction !== ''
      "
    >
      {{ profile.self_introduction }}
    </p>
    <p class="text-h5 pt-3 font-weight-bold">役職</p>
    {{ profile.status_ja }}
    <p class="text-h5 pt-3 font-weight-bold">都道府県</p>
    {{ profile.prefecture }}
    <div class="pt-3">
      <v-btn  depressed color="success">
        <router-link
          style="text-decoration: none; color: inherit"
          :to="{ path: `/myProfile/edit` }"
          class="font-weight-bold"
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
        .get("/profiles/mypage", {
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