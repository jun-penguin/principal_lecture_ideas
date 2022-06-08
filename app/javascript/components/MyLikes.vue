<template>
  <v-container pb-15 class="grey lighten-5 pt-10">
    <h1>参考にした講話一覧</h1>
    <v-row>
      <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4" >
        <v-card class="mx-auto" max-width="344" >
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
    <v-pagination
      class="pt-3"
      v-model="page"
      :length="length"
      @input="changePage"
    ></v-pagination>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import dayjs from "dayjs";
import LikeCount from "./LikeCount.vue";
export default {
  name: "MyLikes",
  components: {
    LikeCount,
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
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  async mounted() {
    await this.$axios
      .get("/api/mylikes", {
        headers: {
          uid: this.headers["uid"],
          "access-token": this.headers["access-token"],
          client: this.headers["client"],
        },
      })
      .then((res) => {
        const posts = res.data.posts;
        for (const post of posts) {
          post.readActivated = false;
        }
        this.posts = posts;
      });
    this.length = Math.ceil(this.posts.length / this.pageSize);
    this.viewPosts = this.posts.slice(0, this.pageSize);
    console.info(dayjs().format());
    this.$watch("$route.query.page", {
      handler: function () {
        console.log("watch");
        this.page = Number(this.$route.query.page || 1);
        this.handlePageChange(Number(this.$route.query.page) || 1);
      },
      immediate: true,
    });
  },

  methods: {
    handlePageChange: function (pageNumber) {
      this.viewPosts = this.posts.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },

    formatDate: (dateStr) => dayjs(dateStr).format("YYYY年MM月DD日"),
    changePage: function () {
      console.log("routerPush");
      this.$router.push({
        query: {
          page: Number(this.page),
        },
      });
    },
  },
};
</script>

<style scoped></style>