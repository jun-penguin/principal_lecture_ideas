<template>
  <v-container class="grey lighten-5">
    <h1>投稿した講話一覧</h1>
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
              <router-link :to="'/post/' + post.id">
                講話の詳細ページへ
              </router-link>
            </v-btn>

            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>  

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
  name: "Postings",
  data: function () {
    return {
      posts: [],
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  mounted() {
    axios
      .get("/api/postings", {
        headers: {
          uid: this.headers["uid"],
          "access-token": this.headers["access-token"],
          client: this.headers["client"],
        },
      })
      .then((res) => (this.posts = res.data.posts));
  },
};
</script>

<style scoped></style>