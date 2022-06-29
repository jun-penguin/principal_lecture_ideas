<template>
  <!-- 検索フォーム -->
  <v-text-field
    v-model="query.title_or_description_or_content_cont"
    placeholder="タイトル・概要・本文で検索"
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
      // posts: [],
      query: {
        title_or_description_or_content_cont: null,
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
        .get("/posts/search", {
          params: {
            q: this.query,
          },
          paramsSerializer: function (params) {
            return Qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .then((res) => {
          console.log(res.data.posts);
          console.log("検索完了");

          const posts = res.data.posts;
          for (const post of posts) {
            post.readActivated = false;
          }
          // this.posts = posts;
          this.$store.dispatch("responseDate/getPosts", {
            posts: posts,
          })
          this.$store.dispatch("responseDate/getWord", {
            word: this.query.title_or_description_or_content_cont
          })
          this.$store.dispatch("responseDate/getGrade_range", {
            grade_range: null
          });
          this.$store.dispatch("responseDate/getScene_type", {
            scene_type: null
          });
          this.$router.push({
            name: "SearchResult",
            // params: {
            //   title_or_description_or_content_cont:
            //     this.query.title_or_description_or_content_cont,
            // },
            query: {
                t: new Date().getTime(),
                // page: 1,
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