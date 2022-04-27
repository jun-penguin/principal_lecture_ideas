<template>
  <v-dialog v-model="dialog" max-width="600px">
    <template v-slot:activator="{ on }">
      <v-btn round flat large color="primary" class="mr-2" v-on="on">新規登録</v-btn>
    </template>
    <v-card>
      <v-card-title>
        <span class="headline">新規登録</span>
        <v-spacer></v-spacer>
        <v-btn icon @click="dialog = false">
          <v-icon>close</v-icon>
        </v-btn>
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field label="ユーザー名" required></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field label="メールアドレス" required></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-text-field
                label="パスワード"
                type="password"
                required
              ></v-text-field>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-container grid-list-md>
          <v-btn block color="success" dark @click="dialog = false">登録</v-btn>
        </v-container>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
    };
  },
};
</script>