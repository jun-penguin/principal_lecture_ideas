<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">参考にした講話一覧</p>
    <p class="pt-5 pl-3 font-weight-bold" v-if="!this.posts.length">
      参考にした講話はありません。
    </p>
    <!-- コンポーネント呼び出し -->
    <SharedPostIndex v-if="posts" :shared_posts="this.posts" />
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import SharedPostIndex from "../parts/SharedPostIndex.vue";
export default {
  name: "Favorites",
  components: {
    SharedPostIndex,
  },
  data: function () {
    return {
      posts: null,
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  created() {
    console.log("親のcreated発火");
    this.$axios
      .get("/likes/favorites", {
        headers: {
          uid: this.headers["uid"],
          "access-token": this.headers["access-token"],
          client: this.headers["client"],
        },
      })
      .then((response) => {
        this.posts = response.data.posts;
        console.log("likepost取得完了");
      });
  },
};
</script>

<style scoped>
.description {
  padding: 0.5em 1em;
  margin: 2em 0;
  color: #232323;
  background: #f5f5f5;
  border-left: solid 5px #5d5d5d;
  font-size: 15px;
}
</style>