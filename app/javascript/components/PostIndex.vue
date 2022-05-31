<template>
  <div>
    <TopPage />
    <v-container pb-15 class="grey lighten-5">
      <p class="text-h5 text-center title font-weight-bold">講話一覧(新着順)</p>
      <v-row>
        <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4">
          <v-card class="mx-auto" max-width="344">
            <v-card-text>
              <div>
                
                投稿者: {{ post.user.name }}
                <!-- likecount -->
                <span class="ml-8">
                  <!-- v-if="loggedIn" -->
                  <LikeCount :postId="post.id" />
                </span>
              </div>
              <div>
                <router-link
                  :to="{ path: `/post/${post.id}` }"
                  style="text-decoration: none"
                >
                  <p class="text-h5 orange--text">{{ post.title }}</p>
                </router-link>
              </div>
              <p>{{ post.grade_range_ja }} {{ post.scene_type_ja }}</p>
              <p>更新日 {{ formatDate(post.updated_at) }}</p>
              <!-- readmore部分 -->
              <div>
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
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
      <v-pagination class="pt-3"
        v-model="page"
        :length="length"
        @input="handlePageChange"
      ></v-pagination>
    </v-container>
  </div>
</template>

<script>
// import { mapState } from "vuex";
import TopPage from "./TopPage.vue";
import dayjs from "dayjs";
import LikeCount from "./LikeCount.vue";
export default {
  name: "PostIndex",
  components: {
    LikeCount,
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
  // computed: {
  //   ...mapState("auth", {
  //     loggedIn: (state) => state.loggedIn,
  //   }),
  // },
  async mounted() {
    await this.$axios.get("/api/posts").then((res) => {
      const posts = res.data.posts;
      for (const post of posts) {
        post.readActivated = false;
      }
      this.posts = posts;
    });
    this.length = Math.ceil(this.posts.length / this.pageSize);
    this.viewPosts = this.posts.slice(0, this.pageSize);
    console.info(dayjs().format());
  },

  methods: {
    handlePageChange: function (pageNumber) {
      this.viewPosts = this.posts.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },

    formatDate: (dateStr) => dayjs(dateStr).format("YYYY年MM月DD日"),
  },
};
</script>

<style scoped></style>