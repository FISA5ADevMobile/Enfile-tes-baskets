import React from "react";
import { TextField } from "@mui/material";
import { Link } from "react-router-dom";
import { Button } from "@mui/material";
import { Checkbox } from "@mui/material";

const LoginPage = () => {
  const [loginData, setLoginData] = React.useState({
    email: "",
    password: "",
  });

  const [rememberMe, setRememberMe] = React.useState(false);

  return (
    <div
      className="flex items-center justify-center min-h-screen bg-cover bg-center"
      style={{
        backgroundImage: `url('https://images.unsplash.com/photo-1546717003-caee5f93a9db?q=80&w=2878&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')`, // Lien vers une image aléatoire
      }}
    >
      <div className="bg-gray-800 bg-opacity-50 rounded-lg shadow-lg p-8 w-full max-w-md">
        {/* bg-opacity-90 */}
        <img
          src="/images/app-logo.png"
          alt="Logo"
          className="mx-auto mb-6 bg-opacity-90"
          width={100}
        />
        <h1 className="text-2xl font-bold text-center mb-6">Connexion</h1>
        <form>
          <div className="mb-4">
            <TextField
              fullWidth
              id="outlined-basic"
              label="Adresse email"
              variant="outlined"
              color="primary"
              type="email"
              onChange={(e) =>
                setLoginData({ ...loginData, email: e.target.value })
              }
            />
          </div>
          <div className="mb-6">
            <TextField
              fullWidth
              id="outlined-basic"
              label="Mot de passe"
              variant="outlined"
              color="primary"
              type="password"
              onChange={(e) =>
                setLoginData({ ...loginData, password: e.target.value })
              }
            />
          </div>

          <div className="flex items-center justify-start mb-6">
            <Checkbox
              focusRipple
              fullWidth
              color="primary"
              checked={rememberMe}
              onChange={(e) => setRememberMe(e.target.checked)}
            />
            <p className="text-white-600">Se souvenir de moi</p>
          </div>
          <Button
            variant="contained"
            fullWidth
            color="primary"
            onClick={() => {
              window.location.href = "/";
            }}
          >
            Se connecter
          </Button>
        </form>
        <p className="mt-6 text-center text-sm text-white-600">
          Mot de passe oublié?{" "}
          <a
            href="/mot-de-passe-oublie"
            className="text-yellow-600 hover:underline"
          >
            Cliquez ici
          </a>
        </p>
        <p className="mt-6 text-center text-sm text-white-600">
          Pas de compte?{" "}
          <a
            href="/inscription"
            className="text-yellow-600 hover:underline"
          >
            Contactez un administrateur
          </a>
        </p>
      </div>
    </div>
  );
};

export default LoginPage;
