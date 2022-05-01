<template>
  <v-container>
    <h1>記事詳細</h1>
    <v-divider></v-divider>
    <h2>タイトル</h2>
    {{ post.title }}
    <h2>投稿者より一言</h2>
    {{ post.description }}
    <h2>本文</h2>
    {{ post.content }}
    <h2>対象</h2>
    　{{ post.grade_range }}
    <h2>シーンタイプ</h2>
    　{{ post.scene_type }}
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  name: "PostDetail",
  data: function () {
    return {
      post: [],
    };
  },
  mounted: function () {
    this.fetchPostDetail();
  },
  methods: {
    fetchPostDetail: function () {
      var id = this.$route.params.id;
      axios.get("/api/posts/" + id).then(
        (response) => {
          this.post = response.data;
          console.log(response);
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