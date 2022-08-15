<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">講話の管理</p>
    <v-tabs>
      <v-tab class="font-weight-bold" href="#tab-1">公開中</v-tab>
      <v-tab class="font-weight-bold" href="#tab-2">下書き</v-tab>
      <!-- 公開中 -->
      <v-tab-item value="tab-1">
        <!-- コンポーネント呼び出し -->
        <SharedPostingsIndex
          v-if="posts"
          :shared_posts="this.publishedFilter"
        />
      </v-tab-item>
      <!-- 下書き -->
      <v-tab-item value="tab-2">
        <!-- コンポーネント呼び出し -->
        <SharedPostingsIndex
          v-if="posts"
          :shared_posts="this.draftFilter"
        />
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
    console.log("親createdフック発火");
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
          console.log("getPostings発火");
          this.posts = response.data.posts;
        });
    },
  },
};
</script>