<template>
  <v-app id="app"> <!-- 追加 -->
  <v-container class="grey lighten-5">
    <h1>投稿一覧</h1>
    <v-row>
      <v-col v-for="post in posts" :key="post.id" cols="12" sm="4">
    <v-card 
    class="mx-auto"
    max-width="344"
  >
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
      <v-btn
        color="orange lighten-2"
        text
      >
        講話の詳細ページへ
      </v-btn>

      <v-spacer></v-spacer>

    </v-card-actions>

    <v-expand-transition>
      <div v-show="show">
        <v-divider></v-divider>
        <v-card-text>
          {{ post.content }}
        </v-card-text>
      </div>
    </v-expand-transition>
  </v-card>
      </v-col>
    </v-row>
  </v-container>
  </v-app>
</template>  

<script>
import axios from 'axios'
export default {
  data: function() {
    return {
      message: "Hello Vue!",
      posts: []
    };
  },
  mounted() {
    axios
    .get('/api/posts')
    .then((res) => (this.posts = res.data.posts))
  }
};
</script>

<style scoped>
</style>