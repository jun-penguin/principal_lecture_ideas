<template>
  <v-container class="grey lighten-5">
    <h1>講話一覧（新着順）</h1>
    <v-row>
      <v-col v-for="post in this.viewPosts" :key="post.id" cols="12" sm="4">
        <v-card class="mx-auto" max-width="344">
          <v-img
            src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
            height="200px"
          ></v-img>

          <v-card-title>
            {{ post.title }}
          </v-card-title>

          <v-card-subtitle>
            {{ post.user.name }}
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
import axios from "axios";
export default {
  name: "PostIndex",
  data: function () {
    return {
      posts: [],
      viewPosts: [],
      length: 0,
      page: 1,
      pageSize:12
    };
  },
  async mounted() {
    await axios.get("/api/posts").then((res) => (this.posts = res.data.posts)
    );
    this.length = Math.ceil(this.posts.length/this.pageSize);
    this.viewPosts = this.posts.slice(0,this.pageSize);
  },

  methods: {
    handlePageChange: function (pageNumber) {
      this.viewPosts = this.posts.slice(this.pageSize * (pageNumber - 1),this.pageSize * (pageNumber))
    },
  },
};
</script>

<style scoped></style>