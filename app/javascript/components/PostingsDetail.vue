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
    <LikeButton class="pb-3" :postId="this.$route.params.id" />
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
</style>