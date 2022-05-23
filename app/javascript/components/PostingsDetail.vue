<template>
  <v-container>
    <h1>記事詳細</h1>
    <v-divider></v-divider>
    <h2>タイトル</h2>
    {{ post.title }}
    <h2>投稿者から講話の紹介</h2>
    {{ post.description }}
    <h2>本文</h2>
    {{ post.content }}
    <h2>対象</h2>
    {{ post.grade_range_ja }}
    <h2>シーンタイプ</h2>
    {{ post.scene_type_ja }}
    <div>
      <v-btn depressed color="success">
        <router-link style="text-decoration: none; color: inherit;"  :to="{ path: `/postings/edit/${post.id}` }" class="btn"
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
import { mapActions } from 'vuex'
export default {
  name: "PostingsDetail",
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
            console.log(response);
            this.user = response.data;
          },
          (error) => {
            console.log(error);
          }
        );
    },
    deletePost: function () {
      var id = this.$route.params.id;
      axios
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
              status: true
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