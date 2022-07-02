import Vue from "vue";
import Router from "vue-router";
import PostDetail from "../components/PostDetail.vue";
import PostIndex from "../components/PostIndex.vue";
import PostCreate from "../components/PostCreate.vue";
import Postings from "../components/Postings.vue";
import PostingsDetail from "../components/PostingsDetail.vue";
import PostingsEdit from "../components/PostingsEdit.vue";
import Search from "../components/Search.vue";
import SearchResult from "../components/SearchResult.vue";
import MyProfile from "../components/MyProfile.vue";
import MyProfileEdit from "../components/MyProfileEdit.vue";
import OtherProfile from "../components/OtherProfile.vue";
import MyLikes from "../components/MyLikes.vue";
import PrivacyPolicy from "../components/PrivacyPolicy.vue";
import Terms from "../components/Terms.vue";

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
      path: "/privacyPolicy",
      name: "PrivacyPolicy",
      component: PrivacyPolicy,
    },
    {
      path: "/terms",
      name: "Terms",
      component: Terms,
    },
    {
      path: "/search",
      name: "Search",
      component: Search,
    },
    {
      path: "/searchResult",
      name: "SearchResult",
      component: SearchResult,
      // beforeEnter: (to, from, next) => {
      //   window.location.reload();
      //   return next();
      // },
      props: true,
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
    {
      path: "/myProfile",
      name: "MyProfile",
      component: MyProfile,
    },
    {
      path: "/myProfile/edit",
      name: "myProfileEdit",
      component: MyProfileEdit,
    },
    {
      path: "/mylikes",
      name: "myLikes",
      component: MyLikes,
    },
    {
      path: "/:username",
      name: "OtherProfile",
      component: OtherProfile,
    },
  ],
});
