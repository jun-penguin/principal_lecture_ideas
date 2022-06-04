const state = {
  posts: [],
  word: null,
  grade_range: null,
  scene_type: null,
};

const getters = {
  posts: (state) => state.posts,
  word: (state) => state.word,
  grade_range: (state) => state.grade_range,
  scene_type: (state) => state.scene_type,
};

const mutations = {
  setPosts(state, posts) {
    state.posts = posts;
  },
  setWord(state, word) {
    state.word = word;
  },
  setGrade_range(state, grade_range) {
    state.grade_range = grade_range;
  },
  setScene_type(state, scene_type) {
    state.scene_type = scene_type;
  },
};

const actions = {
  getPosts({ commit }, posts) {
    commit("setPosts", posts);
  },
  getWord({ commit }, word) {
    commit("setWord", word);
  },
  getGrade_range({ commit }, grade_range) {
    commit("setGrade_range", grade_range);
  },
  getScene_type({ commit }, scene_type) {
    commit("setScene_type", scene_type);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
