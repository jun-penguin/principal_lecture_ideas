<template>
  <v-container>
    <h1>ユーザープロフィール</h1>
    <v-divider></v-divider>
    <h2>ユーザー名</h2>
    {{ name }}
    <h2>メールアドレス</h2>
    {{ headers.uid }}
    <h2>ステータス</h2>
    {{ profile.status }}
    <h2>都道府県</h2>
    {{ profile.prefecture }}
    <h2>一言自己紹介</h2>
    {{ profile.self_introduction }}
    <div>
      <v-btn depressed color="success">
        <router-link style="text-decoration: none; color: inherit;"  :to="{ path: `/myProfile/edit` }" class="btn"
          >編集する</router-link
        >
      </v-btn>
    </div> 
  </v-container>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
  name: "MyProfile",
  data: function () {
    return {
      profile: [],
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
      name: (state) => state.name,
    }),
  },
  mounted: function () {
    this.fetchMyProfile();
  },
  methods: {
    fetchMyProfile: function () {
      axios
        .get("/api/profiles/", {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then(
          (response) => {
            this.profile = response.data;
            console.log(response);
          },
          (error) => {
            console.log(error);
          }
        );
    },
  },
};
</script>

<style scoped>
</style>