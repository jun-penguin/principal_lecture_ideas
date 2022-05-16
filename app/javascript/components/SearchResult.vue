<template>
  <v-container class="grey lighten-5">
    <h1></h1>
    <v-row>
      <p v-if="!posts.length">検索条件に合致する講話はありませんでした。</p>
      <v-col v-for="post in viewPosts" :key="post.id" cols="12" sm="4">
        <v-card class="mx-auto" max-width="344">
          <v-img
            src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
            height="200px"
          ></v-img>

          <v-card-title>
            {{ post.title }}
          </v-card-title>

          <v-card-subtitle>
            {{ post.description }}
          </v-card-subtitle>

          <v-card-actions>
            <v-btn color="orange lighten-2" text>
              <router-link :to="{ path: `/post/${post.id}` }">
                講話の詳細ページへ
              </router-link>
            </v-btn>

            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-col>
      <v-pagination
        v-model="page"
        :length="length"
        @input="handlePageChange"
      ></v-pagination>
    </v-row>
  </v-container>
</template>  

<script>
export default {
  name: "SearchResult",
  props: {
    posts: Array,
  },

  data: function () {
    return {
      viewPosts: [],
      length: 0,
      page: 1,
      pageSize: 12,
    };
  },
  mounted() {
    this.setResult();
  },

  watch: {
    $route() {
      this.setResult();
    },
  },

  methods: {
    setResult: function () {
      this.length = Math.ceil(this.posts.length / this.pageSize);
      this.viewPosts = this.posts.slice(0, this.pageSize);
    },

    handlePageChange: function (pageNumber) {
      this.viewPosts = this.posts.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
  },
};
</script>

<style scoped></style>