<template>
  <v-dialog v-model="dialog" max-width="600px">
    <template v-slot:activator="{ on }">
      <v-btn rounded text large color="primary" class="mr-2" v-on="on"
        >新規登録</v-btn
      >
    </template>
    <v-card>
      <v-form>
      <v-card-title>
        <span class="headline">新規登録</span>
        <v-spacer></v-spacer>
        <v-btn icon @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field
                label="ユーザー名"
                v-model="name"
                required
              ></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field
                label="メールアドレス"
                v-model="email"
                required
              ></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field
                label="パスワード"
                type="password"
                v-model="password"
                required
              ></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field
                label="パスワード（確認用）"
                type="password"
                v-model="password_confirmation"
                required
              ></v-text-field>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-container grid-list-md>
          <div class="error">{{ error }}</div>
          <v-btn block color="success" dark @click="signupHundler">登録</v-btn>
        </v-container>
      </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      dialog: false,
      name: "",
      email: "",
      password: "",
      password_confirmation: "",
      error: null,
    };
  },
  methods: {
    signupHundler: function () {
      this.closeDialog();
      this.signUp();
    },
    closeDialog: function () {
      this.dialog = false;
    },
    async signUp() {
      this.error = null;
      try {
        const res = await axios.post("http://localhost:3000/auth", {
          name: this.name,
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation,
        });
        if (!res) {
          throw new Error("アカウントを登録できませんでした");
        }
        console.log({ res });
        return res;
      } catch (error) {
        this.error = "アカウントを登録できませんでした";
      }
    },
  },
};
</script>