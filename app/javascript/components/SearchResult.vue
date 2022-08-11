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
    <v-row>
      <p class="pt-5 pl-3 font-weight-bold" v-if="!posts.length">
        検索条件に合致する講話はありませんでした。
      </p>
      <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4">
        <v-hover v-slot="{ hover }">
          <router-link :to="{ path: `/post/${post.id}` }">
            <v-card class="mx-auto" max-width="344" :elevation="hover ? 12 : 2">
              <v-card-text>
                <div>
                  <span
                    ><v-icon class="pb-1">mdi-account</v-icon>
                    <span class="font-weight-bold">{{
                      post.user_name
                    }}</span></span
                  >
                  <span class="ml-8">
                    <LikeCount :postId="post.id" />
                  </span>
                   <span class="ml-3">
                      <CommentCount :postId="post.id" />
                    </span>
                </div>
                <div>
                  <!-- <router-link
                :to="{ path: `/post/${post.id}` }"
                style="text-decoration: none"
              > -->
                  <p
                    :style="{ 'text-decoration': hover ? 'underline' : 'none' }"
                    class="text-h5 blue--text font-weight-bold"
                  >
                    {{ post.title }}
                  </p>
                  <!-- </router-link> -->
                </div>
                <p class="font-weight-bold">
                  {{ post.grade_range_ja }} / {{ post.scene_type_ja }}
                </p>
                <p>
                  <v-icon class="pb-1">mdi-clock-outline</v-icon>
                  {{ formatDate(post.updated_at) }}
                </p>

                <!-- 一旦消す -->
                <!-- readmore部分 -->
                <!-- <div>
              <p>
                <span v-if="!post.readActivated">
                  {{ post.description.slice(0, 100) }}
                </span>
                <button
                  class="blue--text"
                  v-if="!post.readActivated && post.description.length > 100"
                  @click="post.readActivated = !post.readActivated"
                >
                  ...もっと読む
                </button>
              </p>
              <p v-if="post.readActivated">{{ post.description }}</p>
              <button
                class="read blue--text"
                v-if="post.readActivated"
                @click="post.readActivated = !post.readActivated"
              >
                閉じる
              </button>
            </div> -->
                <div class="description">
                  <p class="black--text">{{ post.description }}</p>
                </div>
              </v-card-text>
            </v-card>
          </router-link>
        </v-hover>
      </v-col>
    </v-row>
    <v-pagination
      class="pt-3 pb-15"
      v-model="page"
      :length="length"
      @input="changePage"
    ></v-pagination>
  </v-container>
</template>  

<script>
import dayjs from "dayjs";
import LikeCount from "./LikeCount.vue";
import CommentCount from "./CommentCount.vue";
import Qs from "qs";

export default {
  name: "SearchResult",
  components: {
    LikeCount,
    CommentCount
  },

  // props:['title_or_description_or_content_cont'],
  // props: {
  //   title_or_description_or_content_cont: String,
  // },

  data: function () {
    return {
      posts: [],
      viewPosts: [],
      length: 0,
      page: 1,
      pageSize: 12,
      query: {
        title_or_description_or_content_cont_any: null,
        status_eq: 1, //公開済みのみ検索対象に
        grade_range_eq: null,
        scene_type_eq: null,
      },
      grade_range_select: [
        { label: "小学生", value: 0 },
        { label: "中学生", value: 1 },
      ],
      scene_type_select: [
        { label: "全校集会", value: 0 },
        {
          label: "学校行事（運動会、学習発表会、修学旅行、水泳記録会など）",
          value: 1,
        },
        { label: "儀式（入学式、始業式、離任式など）", value: 2 },
        { label: "その他（防災・避難訓練など）", value: 3 },
      ],
    };
  },

  async mounted() {
    console.log("mounted");
    await this.setPosts();
    this.setResult;
    this.setWord;
    this.setGrade_range;
    this.setScene_type;
    this.$watch("$route.query.page", {
      handler: function () {
        console.log("watch.query.page");
        this.page = Number(this.$route.query.page || 1);
        this.handlePageChange(Number(this.$route.query.page) || 1);
      },
      immediate: true,
    });
  },

  computed: {
    setResult: function () {
      this.length = Math.ceil(this.posts.length / this.pageSize);
      this.viewPosts = this.posts.slice(0, this.pageSize);
      console.log("setResult");
    },
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
    async "$route.query.t"() {
      console.log("watchDateTime");
      await this.setPosts();
      this.setResult;
      this.setWord;
      this.setGrade_range;
      this.setScene_type;
    },
    // "query.title_or_description_or_content_cont"() {
    //   this.query.grade_range_eq = null;
    //   this.query.scene_type_eq = null;
    //   console.log("change.query.title_or_description_or_content_cont");
    // },

    // title_or_description_or_content_cont() {
    //   console.log("watch.title_description_cont")
    //   this.query.title_or_description_or_content_cont =
    //     this.title_or_description_or_content_cont;
    // },

    // "$route.query.page": {
    //   handler: function () {
    //     console.log("Hi");
    //     this.handlePageChange(this.$route.query.a.page || 1);
    //     this.page = Number(this.$route.query.a.page || 1);
    //   },
    //   immediate: true,
    // },
  },

  methods: {
    setPosts: function () {
      this.posts = this.$store.getters["responseDate/posts"].posts;
      console.log("setPosts");
      // return this.$store.getters['responseDate/posts'];
    },
    // setResult: function () {
    //   this.length = Math.ceil(this.posts.length / this.pageSize);
    //   this.viewPosts = this.posts.slice(0, this.pageSize);
    //   console.log("setResult");
    // },

    handlePageChange: function (pageNumber) {
      this.viewPosts = this.posts.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
      console.log(this.posts);
      console.log(this.pageSize * (pageNumber - 1));
      console.log(this.pageSize * pageNumber);
      console.log(this.viewPosts);
      // this.$router.push({
      //   query: {
      //     a: {
      //       page: pageNumber,
      //     },

      //     // t: new Date().getTime(),
      //   },
      // })
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
        .then((res) => {
          console.log(res);
          const posts = res.data.posts;
          for (const post of posts) {
            post.readActivated = false;
          }
          // this.posts = posts;
          this.$store.dispatch("responseDate/getPosts", {
            posts: posts,
          });
          this.$store.dispatch("responseDate/getGrade_range", {
            grade_range: this.query.grade_range_eq,
          });
          this.$store.dispatch("responseDate/getScene_type", {
            scene_type: this.query.scene_type_eq,
          });
          this.$router.push({
            // name: "SearchResult",
            // params: { posts: this.posts},
            // params: {
            //   title_or_description_or_content_cont:
            //     this.query.title_or_description_or_content_cont,
            // },
            query: {
              t: new Date().getTime(),
            },
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
    formatDate: (dateStr) => dayjs(dateStr).format("YYYY年MM月DD日"),
    changePage: function () {
      console.log("routerPush");
      this.$router.push({
        // params: {
        //       title_or_description_or_content_cont:
        //         this.query.title_or_description_or_content_cont,
        //     },
        query: {
          page: Number(this.page),
          // t: new Date().getTime()
        },
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
</style>font-size: 15px;