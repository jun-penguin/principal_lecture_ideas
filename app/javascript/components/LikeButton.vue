<template>
  <div v-if="loggedIn">
    <div v-if="isLiked" @click="deleteLike()">
      <v-btn tile color="">
        <v-icon medium left> mdi-heart </v-icon>
        参考になったを取り消す {{ count }}
      </v-btn>
    </div>
    <div v-else @click="registerLike()">
      <v-btn tile color="">
        <v-icon medium left dark> mdi-heart-outline </v-icon>
        参考になりました {{ count }}
      </v-btn>
    </div>
  </div>

  <div v-else>
    <div>
      <v-btn @click="showAlert()" tile color="">
        <v-icon medium left dark> mdi-heart-outline </v-icon>
        参考になりました {{ count }}
      </v-btn>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import { mapActions } from "vuex";
export default {
  props: ["postId"],
  data() {
    return {
      likeList: [],
      current_user_id: null,
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
      loggedIn: (state) => state.loggedIn,
    }),
    // データが変更されるたび動く
    // ここではlikeListが変更される度に、count,isLikedが再構築される
    count() {
      return this.likeList.length;
      // いいね数を返す
    },
    isLiked() {
      // ログインユーザーが既にいいねしてるかを判定する
      if (this.likeList.length === 0) {
        return false;
      }
      return Boolean(this.findLikeId());
    },
  },
  mounted: function () {
    console.log("created")
    // vueインスタンスの作成、初期化直後に実行される
    this.fetchLikeByPostId().then((result) => {
      this.likeList = result.likes;
      this.current_user_id = result.current_user_id;
    });
  },
  methods: {
    ...mapActions("message", ["showMessage"]),
    fetchLikeByPostId: async function () {
      // async function()
      // jsの非同期処理
      console.log("fetchlkebypostid");
      console.log(this.postId)
      const response = await this.$axios.get(
        `/likes/?post_id=${this.postId}`,
        {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        }
      );
      console.log(response.data);
      // await
      // その投稿のいいね一覧を取得したい
      if (response.status !== 200) {
        process.exit();
      }
      // もし処理が失敗したらプロセスから抜ける
      return response.data;
    },
    registerLike: async function () {
      // rails側のcreateアクションにリクエストするメソッド
      const response = await this.$axios.post(
        "/likes",
        {
          post_id: this.postId,
        },
        {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        }
      );
      if (response.status !== 201) {
        process.exit();
      }
      this.fetchLikeByPostId().then((result) => {
        this.likeList = result.likes;
        this.current_user_id = result.current_user_id;
      });
    },
    deleteLike: async function () {
      // rails側のdestroyアクションにリクエストするメソッド
      const likeId = this.findLikeId();
      const response = await this.$axios.delete(`/likes/${likeId}`, {
        headers: {
          uid: this.headers["uid"],
          "access-token": this.headers["access-token"],
          client: this.headers["client"],
        },
      });
      if (response.status !== 200) {
        process.exit();
      }
      this.likeList = this.likeList.filter((n) => n.id !== likeId);
    },
    // ログインユーザーがいいねしているLikeモデルのidを返す
    findLikeId: function () {
      const like = this.likeList.find((like) => {
        return like.user_id == this.current_user_id;
      });
      if (like) {
        return like.id;
      }
    },
    showAlert: function () {
      this.showMessage({
        message: "この操作にはユーザー登録、ログインが必要です",
        type: "warning",
        status: true,
      });
    },
  },
};
</script>

<style scoped>
</style>