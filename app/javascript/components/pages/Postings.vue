<template>
  <v-container class="pb-15 mt-5 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">講話の管理</p>
    <v-tabs>
      <v-tab class="font-weight-bold" href="#tab-1">公開中</v-tab>
      <v-tab class="font-weight-bold" href="#tab-2">下書き</v-tab>
      <!-- 公開中 -->
      <v-tab-item value="tab-1">
        <p
          class="pt-5 pl-3 font-weight-bold"
          v-if="!this.posts || !this.publishedFilter.length"
        >
          公開中の講話はありません。
        </p>
        <!-- コンポーネント呼び出し -->

        <SharedPostingsIndex
          v-if="this.posts"
          :shared_posts="this.publishedFilter"
        />
      </v-tab-item>
      <!-- 下書き -->
      <v-tab-item value="tab-2">
        <p
          class="pt-5 pl-3 font-weight-bold"
          v-if="!this.posts || !this.draftFilter.length"
        >
          下書きの講話はありません。
        </p>
        <!-- コンポーネント呼び出し -->

        <SharedPostingsIndex v-if="this.posts" :shared_posts="this.draftFilter" />
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>


<script>
import SharedPostingsIndex from "../parts/SharedPostingsIndex.vue";
import { mapState } from "vuex";

export default {
  name: "Postings",
  components: {
    SharedPostingsIndex,
  },
  data: function () {
    return {
      posts: null,
      tab: null,
      items: [{ tab: "公開中" }, { tab: "下書き" }],
    };
  },
  head: function () {
    return {
      title: {
        inner: "投稿した講話の管理",
        separator: "|",
        complement: "校長講話アイディアボックス",
      },
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

  created() {
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
        .then((response) => {
          this.posts = response.data.posts;
        });
    },
  },
};
</script>