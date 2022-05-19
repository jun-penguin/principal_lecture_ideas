<template>
  <v-container class="grey lighten-5">
    <h1>講話一覧（新着順）</h1>
    <v-row>
      <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4">
        <v-card class="mx-auto" max-width="344">
          <v-card-text>
            <div>投稿者: {{ post.user.name }}</div>
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
      v-model="page"
      :length="length"
      @input="handlePageChange"
    ></v-pagination>
  </v-container>
</template>

<script>
import axios from "axios";
import dayjs from "dayjs";
export default {
  name: "PostIndex",
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
    await axios.get("/api/posts").then((res) => {
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