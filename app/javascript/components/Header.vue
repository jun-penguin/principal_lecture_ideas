<template>
  <div>
    <v-app-bar color="gray accent-4" dark>
      <v-toolbar-title>Proncipal_lecture_Ideas</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-text-field
        v-model="message"
        label="検索したいワードを入力してください"
        type="text"
      >
        <template v-slot:append-outer>
          <v-btn color="primary">検索</v-btn>
        </template>
      </v-text-field>

      <v-spacer></v-spacer>

      <Signup />
      <Login />

      
    </v-app-bar>
  </div>
</template>

<script>
import Signup from  "./Signup.vue";
import Login from  "./Login.vue";
export default {
  name: "Header",
  components : {
    Signup,
    Login
  },
  data() {
    return {
      message: "",
    };
  },
};
</script>

<style scoped>
</style>
