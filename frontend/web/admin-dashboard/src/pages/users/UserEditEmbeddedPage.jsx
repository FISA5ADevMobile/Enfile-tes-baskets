import React, { useState, useContext, useEffect } from "react";
import { TextField, Button } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Block, Delete, Edit, LockOpen, Save } from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";
import { TIMEOUT_REFRESH } from "../../utils/constants";

const UserEditEmbeddedPage = () => {
  const { userId } = useParams();
  const navigate = useNavigate();

  const { userService } = useContext(AppContext);
  // Default values
  const defaultValues = {
    id: "",
    pseudo: "",
    firstName: "",
    name: "",
    email: "",
    role: "",
    nbPostDeleted: "",
    banDate: "",
  };

  // States
  const [values, setValues] = useState(defaultValues);
  const [isEditing, setIsEditing] = useState(false);
  const [isModified, setIsModified] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  // Function for handling input changes
  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues({ ...values, [name]: value });
    setIsModified(true);
  };

  // Fonction pour réinitialiser les changements
  const handleReset = () => {
    setValues(defaultValues);
    setIsModified(false);
  };

  // Fonction pour la suppression du user (exemple simple)
  const handleDelete = async () => {
    setIsLoading(true);
    const response = await userService.deleteUserById(userId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    //handleReset();
    console.log("Suppression de l'utilisateur");
    dispatchToast("success", "Utilisateur supprimé");
    setTimeout(() => {
      navigate("/utilisateurs");
    }, TIMEOUT_REFRESH);
  };

  const handleBan = async () => {
    setIsLoading(true);
    const response = await userService.banUserById(userId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", "Utilisateur banni");
    setTimeout(() => {
      window.location.reload();
    }, TIMEOUT_REFRESH);
  };

  const handleUnban = async () => {
    setIsLoading(true);
    const response = await userService.unbanUserById(userId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", "Utilisateur debanni");
    setTimeout(() => {
      window.location.reload();
    }, TIMEOUT_REFRESH);
  };

  const getUserById = async () => {
    const response = await userService.getUserById(userId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const user = response.data;
    setValues({
      id: user.id,
      pseudo: user.pseudo,
      firstName: user.firstName,
      name: user.name,
      email: user.email,
      role: user.role,
      nbPostDeleted: user.nbPostDeleted,
      banDate: user?.banDate
        ? handleFormatDateTime(new Date(user.banDate))
        : "",
    });
  };

  const handleResetPassword = async () => {
    const code = Math.floor(10000 + Math.random() * 90000);
    setIsLoading(true);
    const response = await userService.authorizeResetPassword(
      values.email,
      code
    );
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", `Code ${code} à envoyer à l'utilisateur`);
  };

  useEffect(() => {
    getUserById();
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Utilisateurs / ${userId}`} />

      <main className="max-w-4xl mx-auto py-6 px-4 lg:px-8">
        <div className="flex justify-end mb-4 space-x-4">
          {!isLoading && (
            <>
              {/* <Link to="/nouveau-utilisateur">
                <Button
                  variant="text"
                  startIcon={<Add />}
                >
                  Créer un nouveau
                </Button>
              </Link> */}
            </>
          )}
        </div>
        <div
          className="grid grid-cols-1 gap-4 p-8"
          style={{
            backgroundColor: "#18212F",
            borderRadius: "16px",
          }}
        >
          <TextField
            label="ID"
            variant="outlined"
            fullWidth
            name="id"
            value={values.id}
            disabled
          />
          <TextField
            label="Prénom"
            variant="outlined"
            fullWidth
            name="firstName"
            value={values.firstName}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Nom"
            variant="outlined"
            fullWidth
            name="name"
            value={values.name}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Pseudo"
            variant="outlined"
            fullWidth
            name="pseudo"
            value={values.pseudo}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Email"
            variant="outlined"
            fullWidth
            name="email"
            value={values.email}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Role"
            variant="outlined"
            fullWidth
            name="role"
            value={values.role}
            disabled
          />
          <TextField
            label="Nombre de posts supprimés"
            variant="outlined"
            fullWidth
            name="createdAt"
            value={values.nbPostDeleted}
            disabled
          />
          <TextField
            label="Date de bannissement"
            variant="outlined"
            fullWidth
            name="banDate"
            value={values.banDate}
            disabled
          />
        </div>

        <ToastContainer />
        {/* Bouton Enregistrer */}
        <div className="flex flex-row justify-end space-x-4 mt-8">
          {isLoading ? (
            <CircularProgress />
          ) : (
            <>
              <Button
                variant="outlined"
                onClick={handleResetPassword}
                color="success"
                startIcon={<LockOpen />}
              >
                Reinitialiser le mot de passe
              </Button>

              {/* Bouton Bannir */}

              {values.banDate === "" ? (
                <Button
                  variant="outlined"
                  onClick={handleBan}
                  color="error"
                  startIcon={<Block />}
                >
                  Bannir
                </Button>
              ) : (
                <Button
                  variant="outlined"
                  onClick={handleUnban}
                  color="success"
                  startIcon={<Save />}
                >
                  D&eacute;bannir
                </Button>
              )}

              {/* Bouton Supprimer */}
              <Button
                variant="outlined"
                onClick={handleDelete}
                color="error"
                startIcon={<Delete />}
              >
                Supprimer
              </Button>
            </>
          )}
        </div>
      </main>
    </div>
  );
};

export default UserEditEmbeddedPage;
