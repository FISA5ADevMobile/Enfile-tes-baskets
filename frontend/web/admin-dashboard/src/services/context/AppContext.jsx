import { createContext } from "react";
import { AuthService } from "../api/AuthService";
import { ActualityService } from "../api/ActualitiesService";
import { UserService } from "../api/UserService";
import { CommunityService } from "../api/CommunityService";
import { PostService } from "../api/PostService";
import { OrientationCourseService } from "../api/OrientationCourseService";
import { CategoryService } from "../api/CategoryService";
const AppContext = createContext({});
const { Provider } = AppContext;

const AppProvider = ({ children }) => {
  const services = {
    authService: new AuthService(),
    actualityService: new ActualityService(),
    userService: new UserService(),
    communityService: new CommunityService(),
    postService: new PostService(),
    orientationCourseService: new OrientationCourseService(),
    categoryService: new CategoryService(),
  };
  return <Provider value={services}>{children}</Provider>;
};
export { AppContext, AppProvider };
