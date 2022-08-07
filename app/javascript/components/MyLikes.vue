<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">参考にした講話一覧</p>
    <v-row>
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
                  <!-- likecount -->
                  <span class="ml-8">
                    <!-- v-if="loggedIn" -->
                    <LikeCount :postId="post.id" />
                  </span>
                </div>
                <div>
                  <!-- <router-link
                :to="{ path: `/post/${post.id}` }"
                style="text-decoration: none"
              > -->
                  <p
                    :style="{
                      'text-decoration': hover ? 'underline' : 'none',
                    }"
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
      .get("/mylikes", {
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