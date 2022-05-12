import Vue from "vue";
import Router from "vue-router";
import PostDetail from "../components/PostDetail.vue";
import PostIndex from "../components/PostIndex.vue";
import PostCreate from "../components/PostCreate.vue";
import Postings from "../components/Postings.vue";
import PostingsDetail from "../components/PostingsDetail.vue";
import PostingsEdit from "../components/PostingsEdit.vue";
import Search from "../components/Search.vue";

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
      path: "/search",
      name: "Search",
      component: Search,
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
      path: "/postings/:id(\\d+)",
      name: "PostingsDetail",
      component: PostingsDetail,
    },
    {
      path: "/postings/edit/:id(\\d+)",
      name: "PostingsEdit",
      component: PostingsEdit,
    },
    {
      path: "/create",
      name: "PostCreate",
      component: PostCreate,
    },
  ],
});
