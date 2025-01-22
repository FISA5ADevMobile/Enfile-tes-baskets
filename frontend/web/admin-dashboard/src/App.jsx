import { Route, Routes } from "react-router-dom";

// import Sidebar from "./components/common/Sidebar";

import OverviewPage from "./pages/overview/OverviewPage";
import UsersPage from "./pages/users/UsersPage";
import SettingsPage from "./pages/settings/SettingsPage";
import DashboardLayout from "./layouts/DashboardLayout";

import { AppProvider } from "./services/context/AppContext";
import LoginPage from "./pages/auth/LoginPage";
import TestComponent from "./components/common/TestComponent";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import CommunitiesPage from "./pages/communities/CommunitiesPage";
import ActualitiesPage from "./pages/actualities/ActualitiesPage";
import UserEditEmbeddedPage from "./pages/users/UserEditEmbeddedPage";
import ActualityEditEmbeddedPage from "./pages/actualities/ActualityEditEmbeddedPage";
import ActualityCreatePage from "./pages/actualities/ActulityCreatePage";
import CommunityCreatePage from "./pages/communities/CommunityCreatePage";
import CommunityEditEmbeddedPage from "./pages/communities/CommunityEditEmbeddedPage";
import PostEditEmbeddedPage from "./pages/post-publication/PostEditEmbeddedPage";
import PostsPage from "./pages/post-publication/PostsPage";
import TagEditEmbeddedPage from "./pages/orientation-courses/TagEditEmbeddedPage";
import TagCreatePage from "./pages/orientation-courses/TagCreatePage";
import ResetPasswordPage from "./pages/auth/ResetPasswordPage";
import ProtectedRoute from "./ProtectedRoute";
import OrientationCoursesPage from "./pages/orientation-courses/OrientationCoursesPage";
import ClassCreatePage from "./pages/orientation-courses/ClassCreatePage";
import ClassEditEmbeddedPage from "./pages/orientation-courses/ClassEditEmbeddedPage";
import UpdateTagsOfClassPage from "./pages/orientation-courses/UpdateTagsOfClassPage";
import GuidePage from "./pages/settings/GuidePage";

function App() {
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
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
        <div>
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
              path="/reset-password"
              element={<ResetPasswordPage />}
            />

            <Route
              path="/"
              element={
                <ProtectedRoute>
                  <DashboardLayout />
                </ProtectedRoute>
              }
            >
              <Route
                index
                element={<OverviewPage />}
              />
              <Route
                path="/actualites"
                element={<ActualitiesPage />}
              />
              <Route
                path="/actualites/:actualityId"
                element={<ActualityEditEmbeddedPage />}
              />
              <Route
                path="/nouvelle-actualite"
                element={<ActualityCreatePage />}
              />
              <Route
                path="/utilisateurs"
                element={<UsersPage />}
              />
              <Route
                path="/utilisateurs/:userId"
                element={<UserEditEmbeddedPage />}
              />
              <Route
                path="/communautes"
                element={<CommunitiesPage />}
              />
              <Route
                path="/communautes/:communityId"
                element={<CommunityEditEmbeddedPage />}
              />
              <Route
                path="/nouvelle-communaute"
                element={<CommunityCreatePage />}
              />
              <Route
                path="/posts"
                element={<PostsPage />}
              />
              <Route
                path="/posts/:postId"
                element={<PostEditEmbeddedPage />}
              />
              <Route
                path="/parametres"
                element={<SettingsPage />}
              />
              <Route
                path="/parcours-orientation"
                element={<OrientationCoursesPage />}
              />
              <Route
                path="/parcours-orientation/balises/:tagId"
                element={<TagEditEmbeddedPage />}
              />
              <Route
                path="/nouvelle-balise"
                element={<TagCreatePage />}
              />
              <Route
                path="/parcours-orientation/classes/:classId"
                element={<ClassEditEmbeddedPage />}
              />
              <Route
                path="/nouvelle-classe"
                element={<ClassCreatePage />}
              />
              <Route
                path="/parcours-orientation/mettre-a-jour-balises-classe/:classId"
                element={<UpdateTagsOfClassPage />}
              />

              <Route
                path="/aide"
                element={<GuidePage />}
              />
            </Route>
          </Routes>
        </div>
      </AppProvider>
    </ThemeProvider>
  );
}

export default App;
