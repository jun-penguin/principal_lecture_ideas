<template>
  <!-- 検索フォーム -->
  <v-text-field
    v-model="query.title_or_content_cont"
    placeholder="タイトル・本文で検索"
    type="text"
  >
    <template v-slot:append-outer>
      <v-btn @click="search" color="primary">検索</v-btn>
    </template>
  </v-text-field>
</template>

<script>
import Qs from "qs";

export default {
  name: "Search",

  data: function () {
    return {
      posts: [],
      query: {
        title_or_content_cont: null,
        status_eq: 1, //公開済みのみ検索対象に
      },
    };
  },

  watch: {
    $route(to, from) {
      console.log(to, from);
    },
  },

  methods: {
    search: function () {
      this.$axios
        .get("/api/posts/search", {
          params: {
            q: this.query,
          },
          paramsSerializer: function (params) {
            return Qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .then((res) => {
          console.log(res);
          const posts = res.data.posts;
          for (const post of posts) {
            post.readActivated = false;
          }
          this.posts = posts;
          // this.posts = response.data.posts;
          this.$router.push({
            name: "SearchResult",
            params: { posts: this.posts, t: new Date().getTime() },
            query: {
              t: new Date().getTime(),
            },
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>