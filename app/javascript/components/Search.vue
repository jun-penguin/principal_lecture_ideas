<template>
  <v-container class="grey lighten-5">
    <div>
      <input
        v-model="query.title_or_content_cont"
        placeholder="検索したいワードを入力してください"
        type="text"
      />
      <v-btn @click="search" color="primary">検索</v-btn>
      <h1>検索結果</h1>
      <v-row>
        <v-col v-for="post in posts" :key="post.id" cols="12" sm="4">
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
      </v-row>
    </div>
  </v-container>
</template>

<script>
import axios from "axios";
// const Qs = require("qs");
import Qs from "qs";

export default {
  name: "Search",

  data: function () {
    return {
      posts: [],
      query: {
        title_or_content_cont: null,
        status_eq: 1,
      },
    };
  },
  
  methods: {
    search: function () {
      axios
        .get("/api/posts/search", {
          params: {
            q: this.query,
          },
          paramsSerializer: function (params) {
            return Qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .then((response) => {
          console.log(response);
          this.posts = response.data.posts;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>