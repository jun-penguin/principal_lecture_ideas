<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">講話の管理</p>
    <v-tabs>
      <v-tab class="font-weight-bold" href="#tab-1">公開中</v-tab>
      <v-tab class="font-weight-bold" href="#tab-2">下書き</v-tab>
      <!-- 公開中 -->
      <v-tab-item value="tab-1">
        <v-row class="pt-5 pl-3 pr-3">
          <v-col
            v-for="post in publishedFilter"
            :key="post.id"
            cols="12"
            sm="4"
          >
            <v-hover v-slot="{ hover }">
              <router-link :to="{ path: `/postings/${post.id}` }">
                <v-card
                  class="mx-auto"
                  max-width="344"
                  :elevation="hover ? 12 : 2"
                >
                  <v-card-text>
                    <div>
                      <!-- <router-link
                    :to="{ path: `/postings/${post.id}` }"
                    style="text-decoration: none"
                  > -->
                      <p
                        :style="{
                          'text-decoration': hover ? 'underline' : 'none',
                        }"
                        class="text-h5 font-weight-bold blue--text"
                      >
                        {{ post.title }}
                      </p>
                      <!-- </router-link> -->
                      <span class="pt-n5">
                        <LikeCount :postId="post.id" />
                      </span>
                      <span class="ml-3">
                        <CommentCount :postId="post.id" />
                      </span>
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
      </v-tab-item>
      <!-- 下書き -->
      <v-tab-item value="tab-2">
        <v-row class="pt-5 pl-3 pr-3">
          <v-col v-for="post in draftFilter" :key="post.id" cols="12" sm="4">
            <v-hover v-slot="{ hover }">
              <router-link :to="{ path: `/postings/${post.id}` }">
                <v-card
                  class="mx-auto"
                  max-width="344"
                  :elevation="hover ? 12 : 2"
                >
                  <v-card-text>
                    <div>
                      <!-- <router-link
                    :to="{ path: `/postings/${post.id}` }"
                    style="text-decoration: none"
                  > -->
                      <p
                        :style="{
                          'text-decoration': hover ? 'underline' : 'none',
                        }"
                        class="text-h5 font-weight-bold blue--text"
                      >
                        {{ post.title }}
                      </p>
                      <!-- </router-link> -->
                      <span class="pt-n5">
                        <LikeCount :postId="post.id" />
                      </span>
                      <span class="ml-3">
                        <CommentCount :postId="post.id" />
                      </span>
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

                    <!-- 一旦消す -->
                    <!-- readmore部分 -->
                    <!-- <div>
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
                </div> -->
                  </v-card-text>
                </v-card>
              </router-link>
            </v-hover>
          </v-col>
        </v-row>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>


<script>
import LikeCount from "./LikeCount.vue";
import CommentCount from "./CommentCount.vue";
import { mapState } from "vuex";
import dayjs from "dayjs";
export default {
  name: "Postings",
  components: {
    LikeCount,
    CommentCount,
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
        .get("/postings", {
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