<template>
  <v-container class="pb-15">
    <p class="text-h4 pt-5 title font-weight-bold">{{ post.title }}</p>
    <v-divider></v-divider>
    <div class="text-h6 pt-2 font-weight-bold">
      <p class="float-left">対象: {{ post.grade_range_ja }}</p>
      <p class="float-left pl-7">シーンタイプ: {{ post.scene_type_ja }}</p>

      <p class="text-right">
        投稿者:
        <router-link
          :to="{ path: `/${post.user.name}` }"
          style="text-decoration: none"
        >
          {{ post.user.name }}
        </router-link>
      </p>
    </div>

    <p class="text-h5 pt-2 font-weight-bold">講話の紹介</p>
    {{ post.description }}
    <p class="text-h5 pt-5 font-weight-bold">本文</p>
    {{ post.content }}
    <!-- <p class="text-h5 pt-5 font-weight-bold">対象</p>
    {{ post.grade_range_ja }}
    <p class="text-h5 pt-5 font-weight-bold">シーンタイプ</p>
    {{ post.scene_type_ja }} -->
    <LikeButton class="pt-5 pb-15" :postId="this.post.id" />
  </v-container>
</template>

<script>
import LikeButton from "./LikeButton.vue";
export default {
  name: "PostDetail",
  components: {
    LikeButton,
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
      this.$axios.get("/posts/" + id).then(
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