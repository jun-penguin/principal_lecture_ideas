<template>
  <v-container class="shades white">
    <p class="text-h4 pt-5 title font-weight-bold">
      {{ profile.name }}さんのプロフィール
    </p>
    <v-divider></v-divider>

    <div class="text-h6 pt-2 font-weight-bold">
      <p class="float-left pr-7">役職: {{ profile.status_ja }}</p>
      <p>都道府県: {{ profile.prefecture }}</p>
    </div>

    <p class="text-h5 pt-5 font-weight-bold">一言自己紹介</p>
    <p
      v-if="
        profile.self_introduction !== null && profile.self_introduction !== ''
      "
    >
      {{ profile.self_introduction }}
    </p>
    <p v-else>自己紹介が設定されていません。</p>

    <!-- 投稿一覧 -->
    <p class="text-h5 pt-5 font-weight-bold">
      {{ profile.name }}さんの投稿一覧
    </p>
    <v-divider class="pb-5"></v-divider>
    <v-row>
      <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4">
        <v-hover v-slot="{ hover }">
          <router-link :to="{ path: `/post/${post.id}` }">
            <v-card class="mx-auto" max-width="344" :elevation="hover ? 12 : 2">
              <v-card-text>
                <div>
                  <v-icon class="pb-1">mdi-account</v-icon> {{ post.user.name }}
                  <!-- likecount -->
                  <span class="ml-8">
                    <!-- v-if="loggedIn" -->
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
                    class="text-h5 font-weight-bold blue--text"
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
                </div></v-card-text
              >
            </v-card>
          </router-link>
        </v-hover>
      </v-col>
    </v-row>
    <v-pagination
      class="pt-3 pb-15"
      v-model="page"
      :length="length"
      @input="handlePageChange"
    ></v-pagination>
  </v-container>
</template>

<script>
import dayjs from "dayjs";
import LikeCount from "./LikeCount.vue";
import CommentCount from "./CommentCount.vue";
export default {
  components: {
    LikeCount,
    CommentCount,
  },
  data: function () {
    return {
      profile: [],
      posts: [],
      viewPosts: [],
      length: 0,
      page: 1,
      pageSize: 12,
    };
  },
  async mounted() {
    var username = this.$route.params.username;
    this.fetchProfile();
    await this.$axios.get("/profiles/" + username).then((res) => {
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
    fetchProfile: function () {
      var username = this.$route.params.username;
      this.$axios.get("/profiles/" + username).then(
        (response) => {
          this.profile = response.data;
          console.log(response);
        },
        (error) => {
          console.log(error);
        }
      );
    },
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