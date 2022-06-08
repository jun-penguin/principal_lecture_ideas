<template>
  <v-container>
    <h1>講話詳細</h1>
    <v-divider></v-divider>
    <h2 class="pb-2">タイトル</h2>
    <p class="text-h6">
    {{ post.title }}
    </p>
    <h2 class="pt-4 pb-2">講話の紹介</h2>
    {{ post.description }}
    <h2 class="pt-4 pb-2">本文</h2>
    {{ post.content }}
    <h2 class="pt-4 pb-2">対象</h2>
    {{ post.grade_range_ja }}
    <h2 class="pt-4 ">シーンタイプ</h2>
    {{ post.scene_type_ja }}
    <LikeButton class="pt-5 pb-3" :postId="this.$route.params.id" />
    <div class="pt-4 ">
      <v-btn depressed color="success">
        <router-link
          style="text-decoration: none; color: inherit"
          :to="{ path: `/postings/edit/${post.id}` }"
          class="btn"
          >編集</router-link
        >
      </v-btn>
      <v-btn depressed color="error" v-on:click="deletePost(post.id)">
        削除
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import { mapActions } from "vuex";
import LikeButton from "./LikeButton.vue";
export default {
  name: "PostingsDetail",
  components: {
    LikeButton,
  },
  data: function () {
    return {
      post: [],
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  mounted: function () {
    this.fetchPostingsDetail();
  },
  methods: {
    ...mapActions("message", ["showMessage"]),
    fetchPostingsDetail: function () {
      var id = this.$route.params.id;
      this.$axios
        .get("/api/postings/" + id, {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then(
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
    deletePost: function () {
      var id = this.$route.params.id;
      this.$axios
        .delete("/api/postings/" + id, {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then(
          (response) => {
            this.showMessage({
              message: "講話を削除しました。",
              type: "warning",
              status: true,
            }),
              this.$router.push({ name: "Postings" });
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