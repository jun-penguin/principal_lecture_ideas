<template>
  <!-- 検索フォーム -->
  <v-text-field
    v-model="query.title_or_description_or_content_cont_any"
    placeholder="検索ワードを入力"
    type="text"
  >
    <template v-slot:append-outer>
      <v-btn @click="search" class="font-weight-bold" color="primary"
        >検索</v-btn
      >
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
        title_or_description_or_content_cont_any: null,
      },
    };
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
        .then((response) => {
          console.log("検索完了");
          this.posts = response.data.posts;
          this.$store.dispatch("responseDate/getPosts", {
            posts: this.posts,
          });
          this.$store.dispatch("responseDate/getWord", {
            word: this.query.title_or_description_or_content_cont_any,
          });
          this.$store.dispatch("responseDate/getGrade_range", {
            grade_range: null,
          });
          this.$store.dispatch("responseDate/getScene_type", {
            scene_type: null,
          });
          this.$emit("closeDialog")
          this.$router.push({
            name: "SearchResult",
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