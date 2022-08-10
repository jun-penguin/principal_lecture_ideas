import axios from "axios";

export default axios.create({
  // 開発用
  //  
  // テスト用
  baseURL: "/api/v1/",
  // 本番用
  // baseURL: "https://principal-lecture-ideas.herokuapp.com/api/v1/",
});
