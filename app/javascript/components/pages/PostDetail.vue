<template>
  <v-container class="pb-15 mt-5 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">{{ post.title }}</p>
    <v-divider></v-divider>
    <div class="text-h6 pt-2 font-weight-bold">
      <p class="float-left grade_range_scene_type ml-1 mr-5">
        {{ post.grade_range_ja }}
      </p>
      <p class="float-left grade_range_scene_type">{{ post.scene_type_ja }}</p>

      <p class="text-right">
        投稿者:
        <router-link
          :to="{ path: `/${post.user_name}` }"
          style="text-decoration: none"
        >
          {{ post.user_name }}
        </router-link>
      </p>
    </div>

    <div class="description">
      <p class="text">{{ post.description }}</p>
    </div>
    <div class="content">
      <span class="box-title">講話本文</span>
      <p class="text">{{ newLine(post.content) }}</p>
    </div>
    <!-- 参考になったボタン -->
    <LikeButton @setCurrentUser="setCurrentUser" :postId="this.post.id" />

    <v-divider class="mt-10"></v-divider>

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
    <v-cantainer>
      <v-row class="pb-10">
        <v-col
          v-for="comment in this.comments"
          :key="comment.id"
          cols="12"
          md="8"

        >
          <p class="float-left">
            <v-icon class="pb-1">mdi-account</v-icon>
            <span class="font-weight-bold">{{ comment.user_name }}</span>
          </p>
          <p class="text-right mb-n1 pr-8">
            <v-icon class="pb-1">mdi-clock-outline</v-icon
            >{{ formatDate(comment.updated_at) }}
          </p>
          <div class="comment">
            <p class="mt-n2">
              {{ newLine(comment.body) }}
            </p>
          </div>

          <!-- コメント編集フォーム -->
          <div
            class="text-right pr-8 pt-1"
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
              id="delete-button"
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
      <CommentForm
        v-if="loggedIn"
        @createComment="fetchComments"
        :postId="this.post.id"
      />
    </v-cantainer>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import { mapActions } from "vuex";
import LikeButton from "../parts/LikeButton.vue";
import CommentForm from "../parts/CommentForm.vue";
import CommentEditForm from "../parts/CommentEditForm.vue";
import dayjs from "dayjs";
export default {
  name: "PostDetail",
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
      current_user_id: null,
      dialog: false,
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
      loggedIn: (state) => state.loggedIn,
    }),
  },
  mounted: function () {
    this.fetchPostDetail();
    this.fetchComments();
  },
  methods: {
    ...mapActions("message", ["showMessage"]),
    fetchPostDetail: function () {
      var id = this.$route.params.id;
      this.$axios.get("/posts/" + id).then(
        (response) => {
          this.post = response.data;
          console.log("取得完了");
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
    confirm_dialog(comment) {
      this.dialog = true;
      this.currentComment = comment;
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
.description {
  padding: 0.5em 1em;
  margin: 2em 0;
  color: #232323;
  background: #eafff0;
  border-left: solid 10px #7d420aa4;
  border-radius: 5px;
}
.grade_range_scene_type {
  padding: 0em 0.5em;
  color: #2c2c2f;
  background: #efefef;
  border-radius: 30px;
}

.content {
  position: relative;
  margin: 3em 0;
  padding: 0.5em 1em;
  border: solid 3px #7d420aa4;
  background: #eafff0;
  border-radius: 5px;
}
.content .box-title {
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

.text {
  white-space: pre-line;
  font-size: 19px;
}
.comment {
  padding: 0.5em 1em;
  margin: 0 2em 0 0;
  color: #2c2c2f;
  background: #e4ecf5; /*背景色*/
  border-radius: 5px;
}
.comment p {
  white-space: pre-line;
}
</style>