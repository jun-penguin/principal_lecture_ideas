<template>
  <v-container pb-15 class="grey lighten-5">
    <p class="text-h4 pt-5 title font-weight-bold">検索条件の設定</p>
    <v-select
      v-model="query.grade_range_eq"
      :items="grade_range_select"
      item-text="label"
      item-value="value"
      label="対象学年"
    ></v-select>

    <v-select
      v-model="query.scene_type_eq"
      :items="scene_type_select"
      item-text="label"
      item-value="value"
      label="シーンタイプ"
    ></v-select>

    <v-btn class="mb-10 font-weight-bold" @click="research" color="primary"
      >絞り込む</v-btn
    >

    <p class="text-h4 pt-5 pl-3 title font-weight-bold">検索結果</p>

    <p class="pt-5 pl-3 font-weight-bold" v-if="!posts.length">
      検索条件に合致する講話はありませんでした。
    </p>
    <!-- コンポーネント呼び出し -->
    <SharedPostIndex v-if="posts" :shared_posts="this.posts" />
  </v-container>
</template>  

<script>
import SharedPostIndex from "./SharedPostIndex.vue";
import Qs from "qs";

export default {
  name: "SearchResult",
  components: {
    SharedPostIndex,
  },
  data: function () {
    return {
      posts: null,
      query: {
        title_or_description_or_content_cont_any: null,
        grade_range_eq: null,
        scene_type_eq: null,
      },
      grade_range_select: [
        { label: "小学生", value: 0 },
        { label: "中学生", value: 1 },
      ],
      scene_type_select: [
        { label: "全校朝会", value: 0 },
        {
          label: "学校行事（運動会、学習発表会、修学旅行、水泳記録会など）",
          value: 1,
        },
        { label: "儀式（入学式、始業式、離任式など）", value: 2 },
        { label: "その他（防災・避難訓練など）", value: 3 },
      ],
    };
  },

  async created() {
    console.log("created");
    this.setPosts();
    this.setWord;
    this.setGrade_range;
    this.setScene_type;
  },

  computed: {
    setWord: function () {
      this.query.title_or_description_or_content_cont_any =
        this.$store.getters["responseDate/word"].word;
      console.log("setWord");
    },
    setGrade_range: function () {
      this.query.grade_range_eq =
        this.$store.getters["responseDate/grade_range"].grade_range;
      console.log("setGrade_range");
    },
    setScene_type: function () {
      this.query.scene_type_eq =
        this.$store.getters["responseDate/scene_type"].scene_type;
      console.log("setScene_type");
    },
  },

  watch: {
    "$route.query.t"() {
      this.setPosts();
      this.setWord;
      this.setGrade_range;
      this.setScene_type;
    },
  },

  methods: {
    setPosts: function () {
      this.posts = this.$store.getters["responseDate/posts"].posts;
      console.log("setPosts");
    },
    // 絞り込み検索
    research: function () {
      this.$axios
        .get("/posts/search", {
          params: {
            q: this.query,
          },
          paramsSerializer: function (params) {
            return Qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .then((response) => {
          console.log("絞り込み検索完了");
          this.posts = response.data.posts;
          // this.posts = posts;
          this.$store.dispatch("responseDate/getPosts", {
            posts: this.posts,
          });
          this.$store.dispatch("responseDate/getGrade_range", {
            grade_range: this.query.grade_range_eq,
          });
          this.$store.dispatch("responseDate/getScene_type", {
            scene_type: this.query.scene_type_eq,
          });
          this.$router.push({
            query: {
              t: new Date().getTime(),
            },
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
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