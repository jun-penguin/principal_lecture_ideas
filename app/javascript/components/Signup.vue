<template>
  <v-dialog v-model="dialog" max-width="600px">
    <template v-slot:activator="{ on }">
      <v-btn rounded text large color="white" class="mr-2 font-weight-bold" v-on="on"
        >新規登録</v-btn
      >
    </template>
    <v-card>
      <validation-observer ref="observer" v-slot="{ invalid }">
        <v-form @submit.prevent="submit">
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
                  <validation-provider
                    v-slot="{ errors }"
                    name="ユーザー名"
                    rules="required"
                  >
                    <v-text-field
                      label="ユーザー名"
                      v-model="name"
                      :error-messages="errors"
                      placeholder="ユーザー名は公開されます（登録後にいつでも変更できます）。"
                    ></v-text-field>
                  </validation-provider>
                </v-flex>
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
                </v-flex>
                <v-flex xs12>
                  <validation-provider
                    v-slot="{ errors }"
                    name="パスワード（確認用）"
                    rules="required|confirmed:password"
                  >
                    <v-text-field
                      label="パスワード（確認用）"
                      v-model="password_confirmation"
                      :error-messages="errors"
                      :type="showPasswordConfirm ? 'text' : 'password'"
                      :append-icon="
                        showPasswordConfirm ? 'mdi-eye' : 'mdi-eye-off'
                      "
                      @click:append="showPasswordConfirm = !showPasswordConfirm"
                    ></v-text-field>
                  </validation-provider>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-container grid-list-md>
              <div class="error">{{ error }}</div>
              <v-btn
                block
                color="success"
                :disabled="invalid"
                @click="signupHundler"
                >登録</v-btn
              >
            </v-container>
          </v-card-actions>
        </v-form>
      </validation-observer>
    </v-card>
  </v-dialog>
</template>

<script>
import { required, email, min, confirmed } from "vee-validate/dist/rules";
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
extend("confirmed", {
  ...confirmed,
  message: "{_field_} が一致しません。",
});
export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data() {
    return {
      showPassword: false,
      showPasswordConfirm: false,
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
    signUp: function () {
      this.$store.dispatch("auth/signUp", {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation,
      });
    },
  },
};
</script>