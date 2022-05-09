<template>
  <v-container>
    <h1>講話の編集</h1>
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
            item-text="label"
            item-value="value"
            :items="grade_range_select"
            :error-messages="errors"
            label="対象学年"
            data-vv-name="select"
            required
          ></v-select>
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="想定シーン"
          rules="required"
        >
          <v-select
            v-model="scene_type"
            item-text="label"
            item-value="value"
            :items="scene_type_select"
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
          v-on:click="updatePost"
          color="success"
          :disabled="invalid"
        >
          上記内容で更新する
        </v-btn>
        <v-btn color="blue-grey" class="white--text" @click="clear"> 全て空にする </v-btn>
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
      { label: "全校集会", value: "all_scholl_assembly" },
      { label: "行事", value: "event" },
    ],
    status_select: [
      { label: "下書き（非公開）", value: "draft" },
      { label: "公開", value: "published" },
    ],
  }),
  // post: {
  //   title: "",
  //   description: "",
  //   content: "",
  //   grade_range: null,Ç
  //   scene_type: null,
  //   grade_range_select: ["小学生", "中学生"],
  //   scene_type_select: ["全校集会", "行事"],
  // },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
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
  },
  mounted: function () {
    this.setpostEdit();
  },
  methods: {
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