<template>
  <div>
    <!-- トップページ -->
    <TopPage />
    <v-container mb-15 class="shades white rounded-lg">
      <p class="text-h5 text-center title font-weight-bold">講話一覧(新着順)</p>
      <v-divider class="pb-5"></v-divider>
      <v-row>
        <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4">
          <v-hover v-slot="{ hover }">
            <router-link :to="{ path: `/post/${post.id}` }">
              <v-card
                class="mx-auto"
                max-width="344"
                :elevation="hover ? 12 : 2"
              >
                <v-card-text>
                  <div>
                    <span
                      ><v-icon class="pb-1">mdi-account</v-icon>
                      <span class="font-weight-bold">{{
                        post.user_name
                      }}</span></span
                    >
                    <!-- 参考になった数カウント -->
                    <span class="ml-8">
                      <LikeCount :postId="post.id" />
                    </span>
                    <!-- コメント数カウント -->
                    <span class="ml-3">
                      <CommentCount :postId="post.id" />
                    </span>
                  </div>
                  <div>
                    <p
                      :style="{
                        'text-decoration': hover ? 'underline' : 'none',
                      }"
                      class="text-h5 blue--text font-weight-bold"
                    >
                      {{ post.title }}
                    </p>
                  </div>
                  <p class="font-weight-bold">
                    {{ post.grade_range_ja }} / {{ post.scene_type_ja }}
                  </p>
                  <p>
                    <v-icon class="pb-1">mdi-clock-outline</v-icon>
                    {{ formatDate(post.updated_at) }}
                  </p>
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
        class="pt-3 pb-5"
        v-model="page"
        :length="length"
        @input="changePage"
      ></v-pagination>
    </v-container>
  </div>
</template>

<script>
import TopPage from "./TopPage.vue";
import dayjs from "dayjs";
import LikeCount from "./LikeCount.vue";
import CommentCount from "./CommentCount.vue";
export default {
  name: "PostIndex",
  components: {
    LikeCount,
    CommentCount,
    TopPage,
  },
  data: function () {
    return {
      posts: [],
      viewPosts: [],
      length: 0,
      page: 1,
      pageSize: 12,
    };
  },

  async mounted() {
    await this.$axios.get("/posts").then((response) => {
      this.posts = response.data.posts;
    });
    this.length = Math.ceil(this.posts.length / this.pageSize);
    this.viewPosts = this.posts.slice(0, this.pageSize);
    this.$watch("$route.query.page", {
      handler: function () {
        this.page = Number(this.$route.query.page || 1);
        this.handlePageChange(Number(this.$route.query.page) || 1);
      },
      immediate: true,
    });
  },
// 
  methods: {
    handlePageChange: function (pageNumber) {
      this.viewPosts = this.posts.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },

    // 日付を日本語表記に
    formatDate: (dateStr) => dayjs(dateStr).format("YYYY年MM月DD日"),
    // ブラウザバックで前ページに戻すためにqueryでページ番号を追加している
    changePage: function () {
      this.$router.push({
        query: {
          page: Number(this.page),
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
</style>