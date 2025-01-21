import React from "react";
import { CircularProgress, TextField } from "@mui/material";
import { Link } from "react-router-dom";
import { Button } from "@mui/material";
import { Checkbox } from "@mui/material";
import { AppContext } from "../../services/context/AppContext";
import { toast, ToastContainer } from "react-toastify";
import { dispatchToast } from "../../utils/helper";

const ResetPasswordPage = () => {
  const [passwordReset, setPasswordReset] = React.useState({
    password: "",
    confirmPassword: "",
  });
  const [isLoading, setIsLoading] = React.useState(false);

  const [rememberMe, setRememberMe] = React.useState(false);

  const { userService } = React.useContext(AppContext);

  const handleResetPassword = async () => {
    if (passwordReset.password !== passwordReset.confirmPassword) {
      dispatchToast("error", "Les mots de passe ne correspondent pas");
      return;
    }

    setIsLoading(true);
    const response = await userService.resetPassword(passwordReset);
    setIsLoading(false);
    console.log(response);
    if (response.error) {
      dispatchToast("error", response.message);
      console.log(response.message);
    } else {
      console.log("Mot de passe reinitialisée !");
      dispatchToast("success", "Mot de passe reinitialisée !");
      window.location.href = "/";
    }
  };

  return (
    <div
      className="flex items-center justify-center min-h-screen bg-cover bg-center"
      style={{
        backgroundImage: `url('https://images.unsplash.com/photo-1546717003-caee5f93a9db?q=80&w=2878&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')`, // Lien vers une image aléatoire
      }}
    >
      <ToastContainer />
      <div className="bg-gray-800 bg-opacity-50 rounded-lg shadow-lg p-8 w-full max-w-md">
        {/* bg-opacity-90 */}
        <img
          src="/images/app-logo.png"
          alt="Logo"
          className="mx-auto mb-6 bg-opacity-90"
          width={100}
        />
        <h1 className="text-2xl font-bold text-center mb-6">
          Reset de mot de passe
        </h1>
        <form>
          <div className="mb-6">
            <TextField
              fullWidth
              id="outlined-basic"
              label="Nouveau mot de passe"
              variant="outlined"
              color="primary"
              type="password"
              onChange={(e) =>
                setPasswordReset({ ...passwordReset, password: e.target.value })
              }
            />
          </div>

          <div className="mb-6">
            <TextField
              fullWidth
              id="outlined-basic"
              label="Confirmer le mot de passe"
              variant="outlined"
              color="primary"
              type="password"
              onChange={(e) =>
                setPasswordReset({
                  ...passwordReset,
                  confirmPasswordReset: e.target.value,
                })
              }
            />
          </div>

          {isLoading ? (
            <div className="flex justify-center">
              <CircularProgress />
            </div>
          ) : (
            <Button
              variant="contained"
              fullWidth
              color="primary"
              onClick={() => {
                handleResetPassword();
              }}
            >
              Reinitialiser le mot de passe
            </Button>
          )}
        </form>
      </div>
    </div>
  );
};

export default ResetPasswordPage;
