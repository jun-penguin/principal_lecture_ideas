<template>
  <div>
    <p class="text-h6 pt-5 title font-weight-bold"> <v-icon class="pb-1 pr-3">mdi-comment-edit-outline</v-icon>コメントを書く</p>
    <validation-observer ref="observer" v-slot="{ invalid }">
      <form @submit.prevent="submit">
        <!-- コメント -->
        <validation-provider  name="コメント" rules="required">
          <v-textarea v-model="body" auto-grow label="コメント" rows="1"></v-textarea>
        </validation-provider>
        <v-btn
          class="mr-4 font-weight-bold"
          type="submit"
          color="success"
          v-on:click="createComment"
          :disabled="invalid"
        >
          コメントする
        </v-btn>
        <v-btn @click="clear" class="font-weight-bold"> キャンセル </v-btn>
      </form>
    </validation-observer>
  </div>
</template>

// <script>
import { mapActions } from "vuex";
import { mapState } from "vuex";
import { required } from "vee-validate/dist/rules";
import {
  extend,
  ValidationObserver,
  ValidationProvider,
  setInteractionMode,
} from "vee-validate";

extend('required', required);
setInteractionMode("eager");

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  props: ["postId"],
  data() {
    return {
      body: "",
      current_user_id: null,
    };
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },

  methods: {
    ...mapActions("message", ["showMessage"]),
    submit: function () {
      this.$refs.observer.validate();
    },
    createComment: function () {
      if (!this.headers) return; //headerが空ならばここで処理を終了させる。とりあえずの処置。
      this.$axios
        .post(
          "/comments",
          {
            body: this.body,
            post_id: this.postId,
          },
          {
            headers: {
              uid: this.headers["uid"],
              "access-token": this.headers["access-token"],
              client: this.headers["client"],
            },
          }
        )
        .then(
          (response) => {
            this.showMessage({
              message: "コメントを投稿しました",
              type: "success",
              status: true,
            }),
              this.$emit("createComment");
            this.clear();

            // this.$router.push({ path: "postings" });
          },
          (error) => {
            console.log(error);
          }
        );
    },
    clear() {
      this.body = "";
    },
  },
};
</script>

<style scoped></style>