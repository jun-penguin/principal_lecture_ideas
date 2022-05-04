<template>
  <v-container>
    <h1>新規投稿</h1>
    <validation-observer ref="observer" v-slot="{ invalid }">
      <form @submit.prevent="submit">
        <validation-provider
          v-slot="{ errors }"
          name="タイトル"
          rules="required"
        >
          <v-text-field
            v-model="title"
            :error-messages="errors"
            label="タイトル"
            required
          ></v-text-field>
        </validation-provider>
        <v-text-field
          v-model="description"
          label="投稿者から一言！"
        ></v-text-field>

        <validation-provider v-slot="{ errors }" name="本文" rules="required">
          <v-textarea
            v-model="content"
            :error-messages="errors"
            label="本文"
            auto-grow
            required
          ></v-textarea>
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="対象学年"
          rules="required"
        >
          <v-select
            v-model="grade_range"
            :items="grade_range_select"
            :error-messages="errors"
            label="対象学年"
            data-vv-name="select"
            required
          ></v-select>
          {{ grade_range }}
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="想定シーン"
          rules="required"
        >
          <v-select
            v-model="scene_type"
            :items="scene_type_select"
            :error-messages="errors"
            label="シーンタイプ"
            data-vv-name="select"
            required
          ></v-select>
          {{ scene_type }}
        </validation-provider>

        <v-btn
          class="mr-4"
          type="submit"
          v-on:click="createPost"
          :disabled="invalid"
        >
          投稿する
        </v-btn>
        <v-btn @click="clear"> 全て空にする </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import { required } from "vee-validate/dist/rules";
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

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data: () => ({
    title: "",
    description: "",
    content: "",
    grade_range: null,
    scene_type: null,
    grade_range_select: ["小学生", "中学生"],
    scene_type_select: ["全校集会", "行事"],
  }),
  computed: {
    ja_grade_range: function () {
      if (this.grade_range == "中学生") {
        return (this.grade_range = "junior_high");
      } else {
        return (this.grade_range = "elementary");
      }
    },
    ja_scene_type: function () {
      if (this.scene_type == "行事") {
        return (this.scene_type = "event");
      } else {
        return (this.scene_type = "all_scholl_assembly");
      }
    },
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },

  methods: {
    submit: function () {
      this.$refs.observer.validate();
    },
    createPost: function () {
      if (!this.headers) return; //headerが空ならばここで処理を終了させる。とりあえずの処置。
      axios
        .post(
          "/api/posts",
          {
            title: this.title,
            description: this.description,
            content: this.content,
            grade_range: this.ja_grade_range,
            status: "published",
            scene_type: this.ja_scene_type,
          },
          {
            headers: {
              uid: this.headers["uid"],
              "access-token": this.headers["access-token"],
              client: this.headers["client"],

              // uid: window.localStorage.getItem("uid"),
              // "access-token": window.localStorage.getItem("access-token"),
              // client: window.localStorage.getItem("client"),
            },
          }
        )
        .then(
          (res) => {
            this.$router.push({ path: "/" });
          },
          (error) => {
            console.log(error);
          }
        );
    },
    clear() {
      this.title = "";
      this.description = "";
      this.content = "";
      this.grade_range = "";
      this.scene_type = "";
      this.$refs.observer.reset();
    },
  },
};
</script>

<style scoped></style>