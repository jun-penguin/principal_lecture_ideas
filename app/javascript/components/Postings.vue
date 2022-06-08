<template>
  <v-container class="grey lighten-5">
    <h1>講話の管理</h1>
    <v-tabs>
      <v-tab href="#tab-1">公開中</v-tab>
      <v-tab href="#tab-2">下書き</v-tab>
      <!-- 公開中 -->
      <v-tab-item value="tab-1">
        <v-row class="pt-5">
          <v-col
            v-for="post in publishedFilter"
            :key="post.id"
            cols="12"
            sm="4"
          >
            <v-card class="mx-auto" max-width="344">
              <v-card-text>
                <div>
                  <router-link
                    :to="{ path: `/postings/${post.id}` }"
                    style="text-decoration: none"
                  >
                    <p class="text-h5 orange--text">{{ post.title }}</p>
                  </router-link>
                  <span class="pt-n5">
                    <LikeCount :postId="post.id" />
                  </span>
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
                      v-if="
                        !post.readActivated && post.description.length > 100
                      "
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
      </v-tab-item>
      <!-- 下書き -->
      <v-tab-item value="tab-2">
        <v-row class="pt-5">
          <v-col v-for="post in draftFilter" :key="post.id" cols="12" sm="4">
            <v-card class="mx-auto" max-width="344">
              <v-card-text>
                <div>
                  <router-link
                    :to="{ path: `/postings/${post.id}` }"
                    style="text-decoration: none"
                  >
                    <p class="text-h5 orange--text">{{ post.title }}</p>
                  </router-link>
                  <span class="pt-n5">
                    <LikeCount :postId="post.id" />
                  </span>
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
                      v-if="
                        !post.readActivated && post.description.length > 100
                      "
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
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>


<script>
import LikeCount from "./LikeCount.vue";
import { mapState } from "vuex";
import dayjs from "dayjs";
export default {
  name: "Postings",
  components: {
    LikeCount,
  },
  data: function () {
    return {
      posts: [],
      tab: null,
      items: [{ tab: "公開中" }, { tab: "下書き" }],
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
    draftFilter() {
      const data = this.posts;
      const result = data.filter(function (post) {
        return post.status == "draft";
      });
      return result;
    },
    publishedFilter() {
      const data = this.posts;
      const result = data.filter(function (post) {
        return post.status == "published";
      });
      return result;
    },
  },

  mounted() {
    this.getPostings();
  },

  methods: {
    getPostings() {
      this.$axios
        .get("/api/postings", {
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
    },
    formatDate: (dateStr) => dayjs(dateStr).format("YYYY年MM月DD日"),
  },
};
</script>

<style scoped></style>