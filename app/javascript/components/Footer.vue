<template>
  <!-- <v-footer  class="mt-10" app bottom absolute>
    <v-row class="pt-5" justify="center" no-gutters>
      <v-col class="text-center">
        <p>
          <router-link
            style="cursor:pointer"
            class="mt-5 pr-3 black--text"
            to="/privacyPolicy"
            >プライバシーポリシー</router-link
          >
          <router-link style="cursor:pointer" class="black--text" to="/terms">利用規約</router-link>
        </p>
        <p>
          &copy; 2022 -
          {{ new Date().getFullYear() }} 校長講話アイディアボックス
        </p>
      </v-col>
    </v-row>
  </v-footer> -->
<v-container class="mt-10 pt-10">
  <v-footer color="gray accent-4" dark class="mt-10" bottom fixed   absolute>
    <v-row justify="center" no-gutters>
      <p>
        <router-link
          style="cursor: pointer"
          class="mt-5 pr-3 white--text"
          to="/privacyPolicy"
          >プライバシーポリシー</router-link
        >
        <router-link style="cursor: pointer" class="white--text" to="/terms"
          >利用規約</router-link
        >
      </p>
      <!-- <v-btn
        v-for="link in links"
        :key="link"
        color="white"
        text
        rounded
        class="my-2"
      >
        {{ link }}
      </v-btn> -->
      <v-col class="text-center white--text" cols="12">
        {{ new Date().getFullYear() }} —
        <strong>校長講話アイディアボックス</strong>
      </v-col>
    </v-row>
  </v-footer>
</v-container>
</template>

<script>
import App from "../app.vue";
import PrivacyPolicy from "./PrivacyPolicy.vue";
import Terms from "./Terms.vue";
export default {
  components: {
    PrivacyPolicy,
    Terms,
    App,
  },
  name: "Footer",
};
</script>

<style scoped>
</style>