<template>
  <v-container pb-15>
    <h1>記事詳細</h1>
    <v-divider></v-divider>
    <h2>投稿ユーザー</h2>
     <router-link
                  :to="{ path: `/${post.user.name}` }"
                  style="text-decoration: none"
                >
                  <p> {{ post.user.name }}</p>
                </router-link>
    
    <h2>タイトル</h2>
    {{ post.title }}
    <h2>講話の紹介</h2>
    {{ post.description }}
    <h2>本文</h2>
    {{ post.content }}
    <h2>対象</h2>
    {{ post.grade_range_ja }}
    <h2>シーンタイプ</h2>
    {{ post.scene_type_ja }} 
    <LikeButton :postId="this.post.id" />
  </v-container>
</template>

<script>
import LikeButton from "./LikeButton.vue";
export default {
  name: "PostDetail",
  components: {
    LikeButton
  },
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
      this.$axios.get("/api/posts/" + id).then(
        (response) => {
          this.post = response.data;
          console.log(response);
          this.user = response.data;
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