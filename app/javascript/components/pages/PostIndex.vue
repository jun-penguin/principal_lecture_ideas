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

  async created() {
      this.$axios.get("/posts").then((response) => {
      this.posts = response.data.posts;
    });
  },
// 
};
</script>
