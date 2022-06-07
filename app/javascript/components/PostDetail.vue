<template>
  <v-container class="pb-15">
    <h1>記事詳細</h1>
    <v-divider></v-divider>
    <h2 class="thing">投稿ユーザー</h2>
     <router-link
                  :to="{ path: `/${post.user.name}` }"
                  style="text-decoration: none"
                >
                  <p> {{ post.user.name }}</p>
                </router-link>
    
    <h2 class="pb-2">タイトル</h2>
    {{ post.title }}
    <h2 class="pt-4 pb-2">講話の紹介</h2>
    {{ post.description }}
    <h2 class="pt-4 pb-2">本文</h2>
    {{ post.content }}
    <h2 class="pt-4 pb-2">対象</h2>
    {{ post.grade_range_ja }}
    <h2 class="pt-4 pb-2">シーンタイプ</h2>
    {{ post.scene_type_ja }} 
    <LikeButton class="pt-5"  :postId="this.post.id" />
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
          console.log("取得完了");
          // this.user = response.data;
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