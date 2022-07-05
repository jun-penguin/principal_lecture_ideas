<template>
  <v-container>
    <p class="text-h4 pt-5 title font-weight-bold">プロフィールの編集</p>
    <validation-observer ref="observer" v-slot="{ invalid }">
      <form @submit.prevent="submit">
        <validation-provider
          v-slot="{ errors }"
          name="ユーザーネーム"
          rules="required"
        >
          <v-text-field
            v-model="name"
            :error-messages="errors"
            label="ユーザーネーム"
            required
          ></v-text-field>
        </validation-provider>
        <v-text-field
          v-model="self_introduction"
          label="一言自己紹介"
        ></v-text-field>

        <validation-provider
          v-slot="{ errors }"
          name="ステータス"
          rules="required"
        >
          <v-select
            v-model="status"
            :items="status_select"
            item-text="label"
            item-value="value"
            :error-messages="errors"
            label="ステータス"
            data-vv-name="select"
            required
          ></v-select>
        </validation-provider>

        <validation-provider
          v-slot="{ errors }"
          name="都道府県"
          rules="required"
        >
          <v-select
            v-model="prefecture"
            :items="prefecture_select"
            :error-messages="errors"
            label="都道府県"
            data-vv-name="select"
            required
          ></v-select>
        </validation-provider>

        <v-btn
          class="mr-4 font-weight-bold"
          type="submit"
          v-on:click="updateMyProfile"
          color="success"
          :disabled="invalid"
        >
          上記内容で更新する
        </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
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
  name: "MyProfileEdit",
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data: () => ({
    name: "",
    self_introduction: "",
    status: "",
    prefecture: "",
    status_select: [
      { label: "未設定", value: "not_set" },
      { label: "現小学校校長", value: "elementary_school_principal" },
      { label: "現中学校校長", value: "junior_high_school_principal" },
      { label: "元小学校校長", value: "former_elementary_school_principal" },
      { label: "元中学校校長", value: "former_junior_high_school_principal:" },
    ],
    prefecture_select: [
      "未設定",
      "北海道",
      "青森県",
      "岩手県",
      "宮城県",
      "秋田県",
      "山形県",
      "福島県",
      "茨城県",
      "栃木県",
      "群馬県",
      "埼玉県",
      "千葉県",
      "東京都",
      "神奈川県",
      "新潟県",
      "富山県",
      "石川県",
      "福井県",
      "山梨県",
      "長野県",
      "岐阜県",
      "静岡県",
      "愛知県",
      "三重県",
      "滋賀県",
      "京都府",
      "大阪府",
      "兵庫県",
      "奈良県",
      "和歌山県",
      "鳥取県",
      "島根県",
      "岡山県",
      "広島県",
      "山口県",
      "徳島県",
      "香川県",
      "愛媛県",
      "高知県",
      "福岡県",
      "佐賀県",
      "長崎県",
      "熊本県",
      "大分県",
      "宮崎県",
      "鹿児島県",
      "沖縄県",
    ],
  }),

  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },
  mounted: function () {
    this.setProfileEdit();
  },
  methods: {
    submit: function () {
      this.$refs.observer.validate();
    },
    setProfileEdit: function () {
      this.$axios
        .get(`/profiles/mypage`, {
          headers: {
            uid: this.headers["uid"],
            "access-token": this.headers["access-token"],
            client: this.headers["client"],
          },
        })
        .then((response) => {
          this.name = response.data.name;
          this.self_introduction = response.data.self_introduction;
          this.status = response.data.status;
          this.prefecture = response.data.prefecture;
        });
    },
    updateMyProfile: function () {
      if (!this.headers) return;
      this.$store
        .dispatch("auth/updateProfile", {
          name: this.name,
          self_introduction: this.self_introduction,
          status: this.status,
          prefecture: this.prefecture,
        })
        .then(
          (response) => {
            setTimeout(() => this.$router.push({ name: "MyProfile" }), 500);
            // this.$router.push({ name: "MyProfile" });
          },
          (error) => {
            console.log(error);
          }
        );
    },
  },
};
</script>

<style scoped>
</style>