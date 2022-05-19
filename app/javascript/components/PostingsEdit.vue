<template>
  <v-container>
    <h1>講話の編集</h1>
    <validation-observer ref="observer" v-slot="{ invalid }">
      <form @submit.prevent="submit">
        <!-- タイトル -->
        <validation-provider
          v-slot="{ errors }"
          name="タイトル"
          rules="required"
        >
          <v-text-field
            v-model="title"
            :error-messages="errors"
            label="タイトル"
          ></v-text-field>
        </validation-provider>

        Ï<!-- 講話の紹介 -->
        <validation-provider
          v-slot="{ errors }"
          name="講話の紹介"
          rules="required"
        >
          <v-text-field
            v-model="description"
            label="講話の紹介"
            :error-messages="errors"
            rows="4"
          ></v-text-field>
        </validation-provider>

        <!-- 本文 -->
        <validation-provider v-slot="{ errors }" name="本文" rules="required">
          <v-textarea
            v-model="content"
            :error-messages="errors"
            label="本文"
            auto-grow
          ></v-textarea>
        </validation-provider>

        <!-- 対象選択 -->
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
          ></v-select>
        </validation-provider>

        <!-- シーン選択 -->
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
          ></v-select>
        </validation-provider>

        <!-- 公開設定 -->
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
          ></v-select>
        </validation-provider>

        <v-btn
          class="mr-4"
          type="submit"
          v-on:click="updatePost"
          color="success"
          :disabled="invalid"
        >
          上記内容で更新する
        </v-btn>
        <v-btn color="blue-grey" class="white--text" @click="clear">
          全て空にする
        </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import { mapActions } from "vuex";
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
  name: "PostingsEdit",
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
      { label: "全校集会", value: "all_school_assembly" },
      { label: "行事", value: "event" },
    ],
    status_select: [
      { label: "下書き（非公開）", value: "draft" },
      { label: "公開", value: "published" },
    ],
  }),
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  mounted: function () {
    this.setpostEdit();
  },
  methods: {
    ...mapActions("message", ["showMessage"]),
    ...mapActions("message", ["showMessage"]),
    submit: function () {
      this.$refs.observer.validate();
    },
    setpostEdit: function () {
      var id = this.$route.params.id;
      axios
        .get(`/api/postings/${id}`, {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then((response) => {
          // this.post.id = response.data.id;
          this.title = response.data.title;
          this.description = response.data.description;
          this.content = response.data.content;
          this.grade_range = response.data.grade_range;
          this.scene_type = response.data.scene_type;
          this.status = response.data.status;
        });
    },
    updatePost: function () {
      var id = this.$route.params.id;
      if (!this.headers) return;
      axios
        .put(
          `/api/postings/${id}`,
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
              message: "編集しました。",
              type: "success",
              status: true,
            }),
              this.$router.push({ name: "Postings" });
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