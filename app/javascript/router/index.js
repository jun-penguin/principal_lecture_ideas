import Vue from "vue";
import Router from "vue-router";
import PostDetail from "../components/pages/PostDetail";
import PostIndex from "../components/pages/PostIndex.vue";
import PostCreate from "../components/pages/PostCreate.vue";
import Postings from "../components/pages/Postings.vue";
import PostingsDetail from "../components/pages/PostingsDetail.vue";
import PostingsEdit from "../components/pages/PostingsEdit.vue";
import SearchResult from "../components/pages/SearchResult.vue";
import MyProfile from "../components/pages/MyProfile.vue";
import MyProfileEdit from "../components/pages/MyProfileEdit.vue";
import OtherProfile from "../components/pages/OtherProfile.vue";
import Favorites from "../components/pages/Favorites.vue";
import PrivacyPolicy from "../components/pages/PrivacyPolicy.vue";
import Terms from "../components/pages/Terms.vue";
import store from "../store/store";

Vue.use(Router);

const router = new Router({
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
      path: "/searchResult",
      name: "SearchResult",
      component: SearchResult,
      props: true,
    },
    {
      path: "/postings",
      name: "Postings",
      component: Postings,
      meta: { requiresAuth: true },
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
      meta: { requiresAuth: true },
    },
    {
      path: "/postings/edit/:id(\\d+)",
      name: "PostingsEdit",
      component: PostingsEdit,
      meta: { requiresAuth: true },
    },
    {
      path: "/create",
      name: "PostCreate",
      component: PostCreate,
      meta: { requiresAuth: true },
    },
    {
      path: "/myProfile",
      name: "MyProfile",
      component: MyProfile,
      meta: { requiresAuth: true },
    },
    {
      path: "/myProfile/edit",
      name: "myProfileEdit",
      component: MyProfileEdit,
      meta: { requiresAuth: true },
    },
    {
      path: "/favorites",
      name: "Favorites",
      component: Favorites,
      meta: { requiresAuth: true },
    },
    {
      path: "/:username",
      name: "OtherProfile",
      component: OtherProfile,
    },
  ],
  scrollBehavior(to, from, savedPosition) {

    const searchParams = new URLSearchParams(window.location.search)
    if (savedPosition) {
      console.log("savedPosition発動");
      return savedPosition;
    } 
    if (to.query && searchParams.has("page")) {
      console.log("toQuery発動")
      return { x: 0, y: 1475 };
    }
    console.log("x:0,y:0発動");
      return { x: 0, y: 0 };
  },
});

// ログインが必要なページでの要認証ナビゲーションガード
router.beforeEach((to, from, next) => {
  if (
    to.matched.some((record) => record.meta.requiresAuth) &&
    !store.state.auth.loggedIn
  ) {
    next("/");
  } else {
    next();
  }
});

export default router;
