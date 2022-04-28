<template>
  <v-dialog v-model="dialog" max-width="600px">
    <template v-slot:activator="{ on }">
      <v-btn rounded text large color="primary" v-on="on">ログイン</v-btn>
    </template>
    <v-card>
      <v-card-title>
        <span class="headline">ログイン</span>
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
                label="メールアドレス"
                v-model="email"
                required
              ></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field
                label="パスワード"
                v-model="password"
                type="password"
                required
              ></v-text-field>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-container grid-list-md>
          <div class="error">{{ error }}</div>
          <v-btn block color="success" dark @click="loginHundler"
            >ログイン</v-btn
          >
        </v-container>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>


<script>
import axios from "axios";
export default {
  data() {
    return {
      dialog: false,
      email: "",
      password: "",
      error: null,
    };
  },
  methods: {
    loginHundler: function () {
      this.closeDialog();
      this.login();
    },
    closeDialog: function () {
      this.dialog = false;
    },
    async login() {
      this.error = null;
      try {
        const res = await axios.post("http://localhost:3000/auth/sign_in", {
          email: this.email,
          password: this.password,
        });
        if (!res) {
          throw new Error("メールアドレスかパスワードが違います");
        }
        console.log({ res });
        return res;
      } catch (error) {
        this.error = "メールアドレスかパスワードが違います";
      }
    },
  },
};
</script>