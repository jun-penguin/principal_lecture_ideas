<template>
  <div>
    <section class="main_visual">
      <v-container fluid fill-height class="main_visual_content">
        <v-row>
          <v-col class="text">
            <p>心に残る校長講話を。</p>
            <p class="subtext">
              校長講話アイディアボックスは、全国の校長先生がお持ちの講話アイディアを<br />
              共有するプラットフォームです。
            </p>
          </v-col>
        </v-row>
        <v-row> </v-row>
      </v-container>
    </section>
    <section>
      <div>
        <p class="text-h4 title font-weight-bold text-center pt-10 pb-10">
          コンセプト
        </p>
        <p class="concept_description">
          校長講話アイディアボックスは、全国の校長先生と元校長先生の皆様が<br />お持ちの講話アイディアの共有をしていただくことを通じ、<br />
          多様性に富み、かつ時事に即した講話を集約します。<br />校長先生の皆様の講話づくりの手助けをすることで、<br />子どもたちの教育をより良いものにすることを目指すサービスです。<br />
        </p>
      </div>
    </section>
    <v-container fluid class="pb-10">
      <p class="text-h4 title font-weight-bold text-center pt-10 pb-10">
        サービスの使い方
      </p>
      <v-row class="pb-10">
        <v-col cols="12" sm="4">
          <v-card class="mx-auto pt-5" max-width="344">
            <v-img
              class="pt-10 mx-auto"
              v-bind:src="require('../../../assets/images/glass.jpeg')"
              max-height="100px"
              max-width="100px"
            ></v-img>

            <v-card-title class="justify-center font-weight-bold">
              見つける
            </v-card-title>

            <v-card-subtitle class="text-center">
              サイト上部の検索バーを活用しながら、<br />お探しの条件に合致する講話を検索することができます。<br />
            </v-card-subtitle>
          </v-card>
        </v-col>
        <v-col cols="12" sm="4">
          <v-card class="mx-auto pt-5" max-width="344" max-height="300">
            <v-img
              class="mx-auto"
              v-bind:src="require('../../../assets/images/bookmark.jpeg')"
              max-height="100px"
              max-width="100px"
            ></v-img>

            <v-card-title class="justify-center font-weight-bold">
              参考にする
            </v-card-title>
            <v-card-subtitle class="text-center">
              参考にしたい講話は「参考にする」ボタンや<br />コメント機能を活用することで、<br />
              投稿者に感謝を示すことができます。
            </v-card-subtitle>
          </v-card>
        </v-col>
        <v-col cols="12" sm="4">
          <v-card class="mx-auto pt-5" max-width="344">
            <v-img
              class="mx-auto"
              v-bind:src="require('../../../assets/images/pen.jpeg')"
              max-height="100px"
              max-width="100px"
            ></v-img>

            <v-card-title class="justify-center font-weight-bold">
              投稿する
            </v-card-title>

            <v-card-subtitle class="text-center"
              >お持ちの講話アイディアを投稿することで、<br />プラットフォームを充実させ、全国の校長先生にアイディアを提供することができます。<br />
            </v-card-subtitle>
          </v-card>
          <p class="text-caption">
            ※「参考にする」「コメントする」「投稿する」機能の使用にはユーザー登録が必要です。
          </p>
        </v-col>
      </v-row>

      <v-row class="justify-center" v-if="!loggedIn">
        <v-btn
          class="mr-4 font-weight-bold"
          v-on:click="guestLogIn"
          color="success"
        >
          ゲストユーザーとしてログイン
        </v-btn>
      </v-row>
    </v-container>
  </div>
</template>


<script>
import { mapState } from "vuex";
export default {
  computed: {
    ...mapState("auth", {
      loggedIn: (state) => state.loggedIn,
    }),
  },
  methods: {
    guestLogIn() {
      this.$store.dispatch("auth/guestLogIn");
    },
  },
};
</script>

<style scoped>
.main_visual_content {
  background: url("../../../assets/images/class_room.jpeg");
  background-size: cover;
  background-position: center;
  width: 100%;
  height: 50vh;
}

.main_visual_content .text {
  color: white;
  text-align: center;
  font-size: 40px;
  font-weight: bold;
  position: absolute;
}
.main_visual_content .subtext {
  font-size: 20px;
}

.concept_description {
  text-align: center;
  font-size: 19px;
  line-height: 2.5;
  letter-spacing: 0.5px;
  margin-top: 30px;
  margin-bottom: 30px;
}
</style>