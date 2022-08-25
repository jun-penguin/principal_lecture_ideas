<template>
  <v-container class="mt-10 pt-10">
    <v-footer color="gray accent-4" dark class="mt-10" bottom fixed absolute>
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
          <a
            href="https://docs.google.com/forms/d/e/1FAIpQLSc0D0lRghyKH68-zedNLF72WT5B-Y-6NcdoDS-QhWb-3Py_0g/viewform?usp=sf_link"
            class="pl-3"
            style="text-decoration: none; color: inherit"
            >お問合せ</a
          >
        </p>
        <v-col class="text-center white--text" cols="12">
          {{ new Date().getFullYear() }} —
          <strong>校長講話アイディアボックス</strong>
        </v-col>
      </v-row>
    </v-footer>
  </v-container>
</template>

<script>
import App from "../../app.vue";
import PrivacyPolicy from "../pages/PrivacyPolicy.vue";
import Terms from "../pages/Terms.vue";
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