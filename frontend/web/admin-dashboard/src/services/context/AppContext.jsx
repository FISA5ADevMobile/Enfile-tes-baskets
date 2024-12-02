import { createContext } from "react";
import { AuthService } from "../api/AuthService";

const AppContext = createContext({});
const { Provider } = AppContext;

const AppProvider = ({ children }) => {
  const services = {
    authService: new AuthService(),
  };
  return <Provider value={services}>{children}</Provider>;
};
export { AppContext, AppProvider };
