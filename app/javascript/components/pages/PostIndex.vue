<template>
  <div>
    <!-- トップページ -->
    <TopPage />
    <v-container mb-15 class="shades white rounded-lg">
      <p class="text-h5 text-center title font-weight-bold">講話一覧(新着順)</p>
      <v-divider class="pb-5"></v-divider>

      <!-- コンポーネント呼び出し -->
      <SharedPostIndex v-if="posts" :shared_posts="this.posts" />
    </v-container>
  </div>
</template>

<script>
import TopPage from "../parts/TopPage.vue";
import SharedPostIndex from "../parts/SharedPostIndex.vue";
export default {
  name: "PostIndex",
  components: {
    SharedPostIndex,
    TopPage,
  },
  data: function () {
    return {
      posts: null,
    };
  },
  head: function () {
    return {
      title: {
        inner: "心に残る校長講話を",
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
          content: ["校長講話", "校長講話集", "ネタ"],
          id: "keywords",
        },
        { property: "og:title", content: "校長講話アイディアボックス -校長講話共有サイト", id: "og-title" },
        {
          property: "og:description",
          content:
            "校長講話アイディアボックスは、全国の校長先生がお持ちの講話アイディアを共有するプラットフォームです。",
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

  async created() {
    this.$axios.get("/posts").then((response) => {
      this.posts = response.data.posts;
    });
  },
  //
};
</script>
