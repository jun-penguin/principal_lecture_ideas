import Vue from "vue";
import Router from "vue-router";
import PostDetail from "../components/PostDetail.vue";
import PostIndex from "../components/PostIndex.vue";
import PostCreate from "../components/PostCreate.vue";
import Postings from "../components/Postings.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    {
      path: "/",
      name: "PostIndex",
      component: PostIndex,
    },
    {
      path: "/postings",
      name: "Postings",
      component: Postings,
    },
    {
      path: "/post/:id(\\d+)",
      name: "PostDetail",
      component: PostDetail,
    },
    {
      path: "/create",
      name: "PostCreate",
      component: PostCreate,
    },
  ],
});