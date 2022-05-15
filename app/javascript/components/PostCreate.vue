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
            item-text="label"
            item-value="value"
            :error-messages="errors"
            label="対象学年"
            data-vv-name="select"
            required
          ></v-select>
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="シーンタイプ"
          rules="required"
        >
          <v-select
            v-model="scene_type"
            :items="scene_type_select"
            item-text="label"
            item-value="value"
            :error-messages="errors"
            label="シーンタイプ"
            data-vv-name="select"
            required
          ></v-select>
        </validation-provider>
        
        <validation-provider
          v-slot="{ errors }"
          name="公開設定"
          rules="required"
        >
          <v-select
            v-model="status"
            :items="status_select"
            item-text="label"
            item-value="value"
            :error-messages="errors"
            label="公開設定"
            data-vv-name="select"
            required
          ></v-select>
        </validation-provider>

        <v-btn
          class="mr-4"
          type="submit"
          color="success"
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
import { mapActions } from 'vuex'
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
    grade_range: "",
    scene_type: "",
    status: "",
    grade_range_select: [
      { label: "小学生", value: "elementary" },
      { label: "中学生", value: "junior_high" },
    ],
    scene_type_select: [
      { label: "全校集会", value: "all_scholl_assembly" },
      { label: "行事", value: "event" },
    ],
    status_select: [
      { label: "下書き（非公開）", value: "draft" },
      { label: "公開", value: "published" },
    ],
  }),
  computed: {
    // ja_grade_range: function () {
    //   if (this.grade_range == "中学生") {
    //     return (this.grade_range = "junior_high");
    //   } else {
    //     return (this.grade_range = "elementary");
    //   }
    // },
    // ja_scene_type: function () {
    //   if (this.scene_type == "行事") {
    //     return (this.scene_type = "event");
    //   } else {
    //     return (this.scene_type = "all_scholl_assembly");
    //   }
    // },
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },

  methods: {
    ...mapActions("message", ["showMessage"]),
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
            grade_range: this.grade_range,
            scene_type: this.scene_type,
            status: this.status,
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
              message: "投稿しました",
              type: "success",
              status: true
            }),
            this.$router.push({ path: "postings" });
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
      this.status = "";
      this.$refs.observer.reset();
    },
  },
};
</script>

<style scoped></style>