<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">{{ post.title }}</p>
    <v-divider></v-divider>
    <div class="text-h6 pt-2 font-weight-bold">
      <span class="box3 ml-1 mr-5">{{ post.grade_range_ja }}</span>
      <span class="box3">{{ post.scene_type_ja }}</span>
    </div>
    <div class="box8">
      <p class="content">{{ post.description }}</p>
    </div>
    <div class="box27">
      <span class="box-title">講話本文</span>
      <p class="content">{{ newLine(post.content) }}</p>
    </div>
    <LikeButton
      @setCurrentUser="setCurrentUser"
      class="pb-3"
      :postId="this.post.id"
    />
    <div class="pt-4">
      <v-btn depressed color="success" class="mr-2">
        <router-link
          style="text-decoration: none; color: inherit"
          :to="{ path: `/postings/edit/${post.id}` }"
          class="font-weight-bold"
          >編集</router-link
        >
      </v-btn>
      <v-btn
        depressed
        color="error"
        class="font-weight-bold"
        @click="confirm_dialog = true"
      >
        削除
      </v-btn>
      <v-dialog v-model="confirm_dialog" max-width="400">
        <v-card>
          <v-card-title>
            <div>確認ダイアログ</div>
          </v-card-title>
          <v-card-text>
            <p>本当に削除しますか？</p>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click="confirm_dialog = false">いいえ、削除しません</v-btn>
            <v-btn @click="deletePost(post.id)" color="error"
              >はい、削除します</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>

      <!-- <v-btn depressed color="error" v-on:click="deletePost(post.id)">
        削除
      </v-btn> -->
    </div>

    <!-- コメント欄↓ -->
    <p class="text-h6 pt-5 pb-3 title font-weight-bold">
      <v-icon class="pb-1 pr-3">mdi-comment-processing-outline</v-icon
      >コメント一覧
    </p>

    <!-- コメントがない場合 -->
    <p v-if="!comments.length" class="text-h8 font-weight-bold">
      現在コメントはありません。
    </p>
    <!-- コメント一覧表示 -->
    <v-container>
      <v-row class="pb-10">
        <v-col
          v-for="comment in this.comments"
          :key="comment.id"
          cols="8"
          sm="8"
        >
          <p class="float-left">
            <v-icon class="pb-1">mdi-account</v-icon>
            <span class="font-weight-bold">{{ comment.user.name }}</span>
          </p>
          <p class="text-right mb-n1 pr-8">
            <v-icon class="pb-1">mdi-clock-outline</v-icon
            >{{ formatDate(comment.updated_at) }}
          </p>
          <div class="body">
            <p class="mt-n2">
              {{ newLine(comment.body) }}
            </p>
          </div>

          <!-- コメント編集フォーム -->
          <div
            class="text-right pr-9 pt-1"
            v-if="current_user_id === comment.user_id"
          >
            <comment-edit-form
              @updateComment="fetchComments"
              :setbody="comment.body"
              :commentid="comment.id"
            />

            <!-- コメント削除用ボタン -->
            <v-btn
              depressed
              color="error"
              class="font-weight-bold"
              @click.stop="confirm_dialog(comment)"
            >
              削除
            </v-btn>
          </div>
          <v-divider class="mt-3"></v-divider> </v-col
      ></v-row>
      <!-- コメント削除用ダイアログ -->
      <v-dialog
        v-model="dialog"
        v-if="currentComment"
        :retain-focus="false"
        max-width="400"
      >
        <v-card>
          <v-card-title>
            <div>確認ダイアログ</div>
          </v-card-title>
          <v-card-text>
            <p>本当に削除しますか？</p>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn @click.stop="dialog = false">いいえ、削除しません</v-btn>
            <v-btn @click.stop="deleteComment(currentComment.id)" color="error"
              >はい、削除します</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>
      <!-- コメント投稿フォーム -->
      <CommentForm @createComment="fetchComments" :postId="this.post.id" />
    </v-container>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import { mapActions } from "vuex";
import LikeButton from "./LikeButton.vue";
import CommentForm from "./CommentForm.vue";
import CommentEditForm from "./CommentEditForm.vue";
import dayjs from "dayjs";
export default {
  name: "PostingsDetail",
  components: {
    LikeButton,
    CommentForm,
    CommentEditForm,
  },
  data: function () {
    return {
      post: [],
      comments: [],
      currentComment: {},
      dialog: false,
      current_user_id: null,
      confirm_dialog: false,
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  mounted: function () {
    this.fetchPostingsDetail();
    this.fetchComments();
  },
  methods: {
    ...mapActions("message", ["showMessage"]),
    fetchPostingsDetail: function () {
      var id = this.$route.params.id;
      this.$axios
        .get("/postings/" + id, {
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
    fetchComments: function () {
      var id = this.$route.params.id;
      this.$axios.get(`/comments?post_id=${id}`).then(
        (response) => {
          this.comments = response.data.comments;
        },
        (error) => {
          console.log(error);
        }
      );
    },
    setCurrentUser(currentUser) {
      this.current_user_id = currentUser;
      console.log("setCurrentUserUser発動");
      console.log(this.current_user_id);
    },
    confirm_comment_dialog(comment) {
      this.dialog = true;
      this.currentComment = comment;
    },
    deletePost: function () {
      var id = this.$route.params.id;
      this.$axios
        .delete("/postings/" + id, {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then(
          (response) => {
            this.confirm_dialog = false;
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
    deleteComment(id) {
      this.$axios
        .delete("/comments/" + id, {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then(
          (response) => {
            this.dialog = false;
            this.showMessage({
              message: "コメントを削除しました。",
              type: "warning",
              status: true,
            }),
              this.fetchComments();
          },
          (error) => {
            console.log(error);
          }
        );
    },
    formatDate: (dateStr) => dayjs(dateStr).format("YYYY年MM月DD日"),
    newLine(content) {
      return content.replace(/\\n/g, "\n");
    },
  },
};
</script>

<style scoped>
.box8 {
  padding: 0.5em 1em;
  margin: 2em 0;
  color: #232323;
  background: #eafff0;
  border-left: solid 10px #7d420aa4;
  border-radius: 5px;
}
.box3 {
  padding: 0.5em 0.5em;
  /* margin: 2em 0; */
  color: #2c2c2f;
  background: #efefef; /*背景色*/
  border-radius: 30px;
}

.box27 {
  position: relative;
  margin: 3em 0 2em 0;
  padding: 0.5em 1em;
  border: solid 3px #7d420aa4;
  background: #eafff0;
  border-radius: 5px;
}
.box27 .box-title {
  position: absolute;
  display: inline-block;
  top: -27px;
  left: -3px;
  padding: 0 9px;
  height: 25px;
  line-height: 25px;
  font-size: 17px;
  background: #7d420aa4;
  color: #ffffff;
  font-weight: bold;
  border-radius: 5px 5px 0 0;
}
.box27 p {
  margin: 0;
  padding: 0;
}
.content {
  white-space: pre-line;
  font-size: 19px;
}
.body {
  white-space: pre-line;
  font-size: 19px;
}
.body {
  padding: 0.5em 1em;
  margin: 0 2em 0 0;
  color: #2c2c2f;
  background: #e4ecf5; /*背景色*/
  border-radius: 5px;
}
.body p {
  white-space: pre-line;
}
</style>