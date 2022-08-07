<template>
  <v-container class="pb-15 mt-5 ml-15 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">講話の編集</p>
    <validation-observer ref="observer" v-slot="{ invalid }">
      <form @submit.prevent="submit">
        <!-- タイトル -->
        <validation-provider
          v-slot="{ errors }"
          name="タイトル"
          rules="required|max_title:25"
        >
          <v-text-field
            v-model="title"
            :error-messages="errors"
            :counter="25"
            label="タイトル"
          ></v-text-field>
        </validation-provider>

        <!-- 講話の紹介 -->
        <validation-provider
          v-slot="{ errors }"
          name="講話の紹介"
          rules="required|max_description:100"
        >
          <v-textarea
            v-model="description"
            label="講話の紹介"
            :counter="100"
            :error-messages="errors"
            rows="2"
          ></v-textarea>
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
          class="mr-4 font-weight-bold"
          type="submit"
          v-on:click="updatePost"
          color="success"
          :disabled="invalid"
        >
          上記内容で更新する
        </v-btn>
        <v-btn color="blue-grey" class="white--text font-weight-bold" @click="clear">
          全て空にする
        </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import { mapActions } from "vuex";
import { required, max } from "vee-validate/dist/rules";
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

extend("max_description", {
  ...max,
  message: "{_field_} は100文字以内でなければなりません。",
});
extend("_title", {
  ...max,
  message: "{_field_} は25文字以内でなければなりません。",
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
      { label: "全校朝会", value: "all_school_assembly" },
      {
        label: "学校行事（運動会、学習発表会、修学旅行、水泳記録会など）",
        value: "event",
      },
      { label: "儀式（入学式、始業式、離任式など）", value: "ceremony" },
      { label: "その他（防災・避難訓練など）", value: "other" },
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
      this.$axios
        .get(`/postings/${id}`, {
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
      this.$axios
        .put(
          `/postings/${id}`,
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