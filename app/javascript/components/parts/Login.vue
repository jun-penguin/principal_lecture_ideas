<template>
  <v-dialog v-model="dialog" max-width="600px">
    <template v-slot:activator="{ on }">
      <v-btn
        rounded
        text
        :class="[{ 'little-text': $vuetify.breakpoint.xs, 'ml-n5': $vuetify.breakpoint.xs}, 'font-weight-bold']"
        color="white"
        v-on="on"
        >ログイン</v-btn
      >
    </template>
    <v-card>
      <validation-observer ref="observer" v-slot="{ invalid }">
        <v-card-title>
          <span class="headline font-weight-bold pl-2">ログイン</span>
          <v-spacer></v-spacer>
          <v-btn icon @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-card-text id="login-form">
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <validation-provider
                  v-slot="{ errors }"
                  name="メールアドレス"
                  rules="required|email"
                >
                  <v-text-field
                    label="メールアドレス"
                    v-model="email"
                    :error-messages="errors"
                  ></v-text-field>
                </validation-provider>
              </v-flex>
              <v-flex xs12>
                <validation-provider
                  v-slot="{ errors }"
                  name="パスワード"
                  rules="required|min:6"
                  vid="password"
                >
                  <v-text-field
                    label="パスワード"
                    v-model="password"
                    :error-messages="errors"
                    :type="showPassword ? 'text' : 'password'"
                    :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                    @click:append="showPassword = !showPassword"
                  ></v-text-field>
                </validation-provider>
                <v-btn
                  block
                  color="success"
                  :disabled="invalid"
                  v-on:click="loginHundler"
                  >ログイン</v-btn
                >
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
      </validation-observer>
    </v-card>
  </v-dialog>
</template>


<script>
import { required, email, min } from "vee-validate/dist/rules";
import {
  extend,
  ValidationObserver,
  ValidationProvider,
  setInteractionMode,
} from "vee-validate";

setInteractionMode("eager");

extend("required", {
  ...required,
  message: "{_field_} は空欄にできません。",
});
extend("email", {
  ...email,
  message: "有効なメールアドレスではありません。",
});
extend("min", {
  ...min,
  message: "{_field_} は6文字以上でなければなりません。",
});
export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data() {
    return {
      showPassword: false,
      dialog: false,
      email: "",
      password: "",
      error: null,
    };
  },
  methods: {
    loginHundler: function () {
      this.closeDialog();
      this.logIn();
    },
    closeDialog: function () {
      this.dialog = false;
    },
    logIn: function () {
      this.$store.dispatch("auth/logIn", {
        email: this.email,
        password: this.password,
      });
    },
  },
};
</script>

<style scoped>
/* .little-text {
  font-size: 3px !important;
} */
</style>