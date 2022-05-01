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
    select: null,
    grade_range: ["elementary", "junior_high"],
    scene_type: ["all_scholl_assembly", "event"],
    grade_range_select: ["elementary", "junior_high"],
    scene_type_select: ["all_scholl_assembly", "event"],
  }),

  methods: {
    submit: function () {
      this.$refs.observer.validate();
    },
    createPost: function () {
      if (!this.title) return;
      axios
        .post("/api/posts", {
          title: this.title,
          description: this.description,
          content: this.content,
          grade_range: elementary,
          status: published,
          scene_type: all_scholl_assembly,
          user_id: 1
        })
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
      // this.select = null;
      this.$refs.observer.reset();
    },
  },
};
</script>

<style scoped></style>