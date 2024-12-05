import { Route, Routes } from "react-router-dom";

// import Sidebar from "./components/common/Sidebar";

import OverviewPage from "./pages/OverviewPage";
import UsersPage from "./pages/UsersPage";
import SettingsPage from "./pages/SettingsPage";
import DashboardLayout from "./layouts/DashboardLayout";

import { AppProvider } from "./services/context/AppContext";
import LoginPage from "./pages/LoginPage";
import TestComponent from "./components/common/TestComponent";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import UserEditEmbedded from "./pages/UserEditEmbeddedPage";
import CommunitiesPage from "./pages/CommunautiesPage";
import OrientationCoursesPage from "./pages/OrientationCoursesPage";
import NewsPage from "./pages/NewsPage";

function App() {
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
      // primary: {
      //   main: "#F3F4F6", // Couleur primaire
      // },
      secondary: {
        main: "#374151", // Couleur secondaire
      },
      background: {
        default: "#18212F", // Couleur de fond
      },
    },
    components: {
      MuiDataGrid: {
        styleOverrides: {
          root: {
            borderRadius: 16,
            backgroundColor: "#18212F", // Couleur de fond pour DataGrid
            border: "1px solid #374151", // Couleur des bordures
          },
          columnHeader: {
            backgroundColor: "#18212F", // Couleur des en-têtes
          },
          footerContainer: {
            backgroundColor: "#18212F", // Couleur du footer
          },
        },
      },
    },
  });
  return (
    <ThemeProvider theme={darkTheme}>
      <CssBaseline /> {/* Applique les styles globaux du thème */}
      <AppProvider>
        {/* <div className="flex h-screen bg-gray-900 text-gray-100 overflow-hidden"> */}
        <div>
          {/* BG */}
          {/* <div className='fixed inset-0 z-0'>
				<div className='absolute inset-0 bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 opacity-80' />
				<div className='absolute inset-0 backdrop-blur-sm' />
			</div> */}

          <Routes>
            <Route
              path="/test"
              element={<TestComponent />}
            />
            <Route
              path="/connexion"
              element={<LoginPage />}
            />

            <Route
              path="/"
              element={<DashboardLayout />}
            >
              <Route
                index
                element={<OverviewPage />}
              />
              <Route
                path="/actualites"
                element={<NewsPage />}
              />
              <Route
                path="/utilisateurs"
                element={<UsersPage />}
              />
              <Route
                path="/utilisateurs/:userId"
                element={<UserEditEmbedded />}
              />
              <Route
                path="/parcours-d-orientation"
                element={<OrientationCoursesPage />}
              />
              <Route
                path="/communautes"
                element={<CommunitiesPage />}
              />
              <Route
                path="/parametres"
                element={<SettingsPage />}
              />
            </Route>
          </Routes>
        </div>
      </AppProvider>
    </ThemeProvider>
  );
}

export default App;
