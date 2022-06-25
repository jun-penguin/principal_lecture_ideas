<template>
  <span>
    <v-icon medium color="red lighten-2" left>mdi-heart</v-icon>
    <span class="ml-n2">{{ count }}</span>
  </span>
</template>

<script>
import { mapState } from "vuex";
export default {
  props: ["postId"],
  data() {
    return {
      likeList: [],
    };
  },
  computed: {
    ...mapState("auth", {
    loggedIn: (state) => state.loggedIn,
    }),
    // データが変更されるたび動く
    // ここではlikeListが変更される度に、count,isLikedが再構築される
    count() {
      return this.likeList.length;
      // いいね数を返す
    },
  },
  created: function () {
    // vueインスタンスの作成、初期化直後に実行される

    this.fetchLikeByPostId().then((result) => {
      this.likeList = result.likes;
    });
  },
  methods: {
    fetchLikeByPostId: async function () {
      // async function()
      // jsの非同期処理
      const response = await this.$axios.get(
        `/likes/?post_id=${this.postId}`
        // {
        //   headers: {
        //     uid: this.headers["uid"],
        //     "access-token": this.headers["access-token"],
        //     client: this.headers["client"],
        //   },
        // }
      );
      // await
      // その投稿のいいね一覧を取得したい
      if (response.status !== 200) {
        process.exit();
      }
      // もし処理が失敗したらプロセスから抜ける(処理をやめる？)
      return response.data;
    },
  },
};
</script>

<style scoped>
</style>