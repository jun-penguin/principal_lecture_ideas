const state = {
  posts: [],
};

const getters = {
  posts: (state) => state.posts,
};

const mutations = {
  setPosts(state, posts) {
    state.posts = posts;
  },
};

const actions = {
  getPosts({ commit }, posts) {
    commit("setPosts", posts);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
