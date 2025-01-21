import { Navigate, Outlet, Route } from "react-router-dom";
import { useContext, useEffect, useState } from "react";
import { AppContext } from "./services/context/AppContext";

const ProtectedRoute = ({ children }) => {
  const { authService } = useContext(AppContext);

  const isAuthenticated = authService.isLoggedIn();

  return isAuthenticated ? (
    children
  ) : (
    <Navigate
      to="/connexion"
      replace
    />
  );
};

export default ProtectedRoute;
