<template>
  <v-container class="shades white">
    <p class="text-h4 pt-5 title font-weight-bold">
      {{ profile.name }}さんのプロフィール
    </p>
    <v-divider></v-divider>

    <div class="text-h6 pt-2 font-weight-bold">
      <p class="float-left pr-7">役職: {{ profile.status_ja }}</p>
      <p>都道府県: {{ profile.prefecture }}</p>
    </div>

    <p class="text-h5 pt-5 font-weight-bold">一言自己紹介</p>
    <p
      v-if="
        profile.self_introduction !== null && profile.self_introduction !== ''
      "
    >
      {{ profile.self_introduction }}
    </p>
    <p v-else>自己紹介が設定されていません。</p>

    <!-- 投稿一覧 -->
    <p class="text-h5 pt-5 font-weight-bold">
      {{ profile.name }}さんの投稿一覧
    </p>
    <v-divider class="pb-5"></v-divider>
    <!-- コンポーネント呼び出し -->
    <SharedPostIndex v-if="posts" :shared_posts="this.posts" />
  </v-container>
</template>

<script>
import SharedPostIndex from "../parts/SharedPostIndex.vue";
export default {
  components: {
    SharedPostIndex,
  },
  data: function () {
    return {
      profile: [],
      posts: null,
    };
  },
  head: function () {
    return {
      title: {
        inner: this.profile.name + "さんのプロフィールページ",
        separator: "|",
        complement: "校長講話アイディアボックス",
      },
      meta: [
        {
          name: "description",
          content:
            "校長講話アイディアボックスは、全国の校長先生がお持ちの講話アイディアを共有するプラットフォームです。",
          id: "description",
        },
      
        {
          name: "keywords",
          content: ["校長講話", "校長講話集", "ネタ", this.profile.name],
          id: "keywords",
        },
      
        {
          property: "og:title",
          content: this.profile.name + "さんのプロフィールページ",
          id: "og-title",
        },
        {
          property: "og:description",
          content:
            this.profile.name +
            "さんのプロフィールページです。" +
            this.profile.name +
            "さんのプロフィールや投稿した講話を確認できます。",
          id: "og-description",
        },
      ],
    };
  },

  // vue-head用
  updated() {
    console.log("updateHead発動");
    this.$emit("updateHead");
  },
  created() {
    console.log("親created開始");
    var username = this.$route.params.username;
    this.fetchProfile();
    this.$axios.get("/profiles/" + username).then((response) => {
      this.posts = response.data.posts;
      console.log("postsデータ取得完了");
    });
  },
  methods: {
    fetchProfile: function () {
      var username = this.$route.params.username;
      this.$axios.get("/profiles/" + username).then(
        (response) => {
          this.profile = response.data;
        },
        (error) => {
          console.log(error);
        }
      );
    },
  },
};
</script>

