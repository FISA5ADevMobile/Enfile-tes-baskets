import { Outlet } from "react-router-dom";
import Sidebar from "../components/common/Sidebar";
// import OverviewPage from "./pages/OverviewPage";
// import ProductsPage from "./pages/ProductsPage";
// import UsersPage from "./pages/UsersPage";
// import SalesPage from "./pages/SalesPage";
// import OrdersPage from "./pages/OrdersPage";
// import AnalyticsPage from "./pages/AnalyticsPage";
// import SettingsPage from "./pages/SettingsPage";

const DashboardLayout = () => {
  return (
    <>
      <Sidebar />
      <Outlet />
    </>
  );
};

export default DashboardLayout;
