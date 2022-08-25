<template>
  <v-container class="pb-15 mt-5 shades white rounded-lg">
    <p class="text-h4 pt-5 title font-weight-bold">新規投稿</p>
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
            placeholder="講話の簡単な紹介文を100字以内でお書きください（こちらに記載いただいた内容がサイトの講話一覧ページに掲載されます）。"
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
            placeholder="最初の挨拶からでも、お話のポイントのみでも、どのような書き方でも構いません。ただし、個人情報等（生徒名、すぐ特定できるニックネーム、地域の有名な山河、旧跡、施設、会社などの固有名詞等）の取り扱いにはご注意ください。"
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
            id="grade_range_select"
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
            id="scene_type_select"
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
            id="status_select"
          ></v-select>
        </validation-provider>

        <v-btn
          class="mr-4 font-weight-bold"
          type="submit"
          color="success"
          v-on:click="createPost"
          :disabled="invalid"
        >
          投稿する
        </v-btn>
        <v-btn @click="clear" class="font-weight-bold"> 全て空にする </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import { mapActions } from "vuex";
import { mapState } from "vuex";
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
extend("max_title", {
  ...max,
  message: "{_field_} は25文字以内でなければなりません。",
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
      { label: "全校朝会", value: "all_school_assembly" },
      {
        label: "学校行事（運動会、学習発表会など）",
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

  methods: {
    ...mapActions("message", ["showMessage"]),
    submit: function () {
      this.$refs.observer.validate();
    },
    createPost: function () {
      if (!this.headers) return; //headerが空ならばここで処理を終了させる。とりあえずの処置。
      this.$axios
        .post(
          "/posts",
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
              status: true,
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