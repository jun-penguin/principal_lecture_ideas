<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <div class="">
      <p class="text-h4 pt-5 title font-weight-bold">{{ post.title }}</p>
      <v-divider></v-divider>
      <div class="text-h6 pt-2 font-weight-bold">
        <p class="float-left box3 ml-1 mr-5">{{ post.grade_range_ja }}</p>
        <p class="float-left box3">{{ post.scene_type_ja }}</p>

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

      <!-- <p class="text-h5 pt-2 font-weight-bold heading">講話の紹介</p>
      <p class="box8 mt-n3">{{ post.description }}</p> -->
      <div class="box8">
        <p class="content">{{ post.description }}</p>
      </div>
      <div class="box27">
        <span class="box-title">講話本文</span>
        <p class="content">{{ newLine(post.content) }}</p>
      </div>
      <!-- <p class="text-h5 pt-5 font-weight-bold">対象</p>
    {{ post.grade_range_ja }}
    <p class="text-h5 pt-5 font-weight-bold">シーンタイプ</p>
    {{ post.scene_type_ja }} -->
      <LikeButton :postId="this.post.id" />
    </div>
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
  padding: 0em 0.5em;
  /* margin: 2em 0; */
  color: #2c2c2f;
  background: #efefef; /*背景色*/
  border-radius: 30px;
}
.heading {
  border-bottom: 4px double #000;
}

.box27 {
  position: relative;
  margin: 3em 0;
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