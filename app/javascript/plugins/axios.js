import axios from "axios";

export default axios.create({
  // 開発用
  baseURL: "http://localhost:3000/api/v1/",
  // テスト用
  // baseURL: "/api/v1/",
  // 本番用
  // baseURL: "https://principal-lecture-ideas.herokuapp.com/api/v1/",
  // 独自ドメイン
  // baseURL: "https://www.kochokouwa-idea.com/api/v1"
});
