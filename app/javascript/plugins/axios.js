import axios from "axios";
let baseUrl;
if (process.env.NODE_ENV == "production") {
  baseUrl = "https://principal-lecture-ideas.herokuapp.com";
} else {
  baseUrl = "http://localhost:3000";
}

const axiosInstance = axios.create({
  baseURL: baseUrl,
});

export default axiosInstance;