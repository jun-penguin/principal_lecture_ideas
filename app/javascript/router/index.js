import Vue          from 'vue';
import Router       from 'vue-router';
import PostDetail   from '../components/PostDetail.vue';
import PostIndex   from '../components/PostIndex.vue';



Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: PostIndex
    },
    {
      path: '/post/:id(\\d+)',
      component: PostDetail
    },
    
  ],
});

