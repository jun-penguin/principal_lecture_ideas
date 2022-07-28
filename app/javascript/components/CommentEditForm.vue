<template>
  <v-dialog v-model="dialog" max-width="600px">
    <template v-slot:activator="{ on }">
      <v-btn depressed color="success" class="font-weight-bold" v-on="on"
        >編集</v-btn
      >
    </template>
    <v-card>
      <validation-observer ref="observer" v-slot="{ invalid }">
        <v-card-title>
          <span class="headline font-weight-bold pl-2">コメントの編集</span>
          <v-spacer></v-spacer>
          <v-btn icon @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <validation-provider
                  v-slot="{ errors }"
                  name="コメント"
                  rules="required"
                >
                  <v-textarea
                    label="コメント"
                    v-model="body"
                    rows="1"
                    auto-grow
                    :error-messages="errors"
                  ></v-textarea>
                </validation-provider>
              </v-flex>
              <v-btn
                block
                color="success"
                :disabled="invalid"
                v-on:click="updateHundler"
                >更新</v-btn
              >
            </v-layout>
          </v-container>
        </v-card-text>
      </validation-observer>
    </v-card>
  </v-dialog>
</template>


<script>
import { mapActions } from "vuex";
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

  props: ["setbody", "commentid"],
  data() {
    return {
      body: "",
      dialog: false,
      error: null,
    };
  },
  mounted: function () {
    this.body = this.setbody;
    var id = this.commentid;
    console.log(id);
  },
  computed: {
    ...mapState("auth", {
      headers: (state) => state.headers,
    }),
  },

  methods: {
    ...mapActions("message", ["showMessage"]),
    updateHundler: function () {
      this.closeDialog();
      this.updateComment();
    },
    updateComment: function () {
      var id = this.commentid;
      this.$axios
        .put(
          `/comments/${id}`,
          {
            body: this.body,
          },
          {
            headers: {
              uid: this.headers["uid"],
              "access-token": this.headers["access-token"],
              client: this.headers["client"],
            },
          }
        )
        .then((response) => {
          this.showMessage({
            message: "コメントを編集しました。",
            type: "success",
            status: true,
          }),
            this.$emit("updateComment");
        });
    },
    closeDialog: function () {
      this.dialog = false;
    },
  },
};
</script>