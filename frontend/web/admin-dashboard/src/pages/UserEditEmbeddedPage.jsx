import React, { useState } from "react";
import { TextField, Button } from "@mui/material";
import Header from "../components/common/Header";
import { Add, Delete, Edit, Save } from "@mui/icons-material";

const UserEditEmbeddedPage = () => {
  // Valeurs par défaut pour les champs
  const defaultValues = {
    firstName: "Alice",
    lastName: "Dupont",
    username: "alice123",
    email: "alice@example.com",
    password: "********",
    pseudo: "alice_pro",
    profilePhoto: "",
    deletedPostsCount: 3,
    banDate: "2023-08-01",
    accountCreationDate: "2020-01-01",
    lastModificationDate: "2023-12-01",
  };

  // État pour les valeurs des inputs
  const [values, setValues] = useState(defaultValues);
  const [isEditing, setIsEditing] = useState({
    firstName: false,
    lastName: false,
    username: false,
    email: false,
    password: false,
    pseudo: false,
    profilePhoto: false,
    deletedPostsCount: false,
    banDate: false,
    accountCreationDate: false,
    lastModificationDate: false,
  });
  const [isModified, setIsModified] = useState(false);

  // Fonction pour gérer le changement dans les inputs
  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues({ ...values, [name]: value });
    setIsModified(true);
  };

  // Fonction pour basculer l'édition des champs
  const handleEdit = (field) => {
    setIsEditing({ ...isEditing, [field]: true });
  };

  // Fonction pour réinitialiser les changements
  const handleReset = () => {
    setValues(defaultValues);
    setIsModified(false);
  };

  // Fonction pour la suppression du profil (exemple simple)
  const handleDelete = () => {
    // Logique de suppression à définir
    console.log("Suppression du profil");
  };

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={"Utilisateurs / userId"} />

      <main className="max-w-4xl mx-auto py-6 px-4 lg:px-8">
        <div className="flex justify-end mb-4 space-x-4">
          <Button
            variant="text"
            startIcon={<Add />}
          >
            Créer un nouveau
          </Button>

          {/* <Button
            variant="text"
            startIcon={<Edit />}
          >
            Modifier
          </Button> */}
        </div>
        <div
          className="grid grid-cols-1 gap-4 p-8"
          style={{
            backgroundColor: "#18212F",
            borderRadius: "16px",
          }}
        >
          <TextField
            label="Prénom"
            variant="outlined"
            fullWidth
            name="firstName"
            value={values.firstName}
            onChange={handleChange}
            onClick={() => handleEdit("firstName")}
            disabled={!isEditing.firstName}
          />
          <TextField
            label="Nom"
            variant="outlined"
            fullWidth
            name="lastName"
            value={values.lastName}
            onChange={handleChange}
            onClick={() => handleEdit("lastName")}
            disabled={!isEditing.lastName}
          />
          <TextField
            label="Pseudo"
            variant="outlined"
            fullWidth
            name="username"
            value={values.username}
            onChange={handleChange}
            onClick={() => handleEdit("username")}
            disabled={!isEditing.username}
          />
          <TextField
            label="Email"
            variant="outlined"
            fullWidth
            name="email"
            value={values.email}
            onChange={handleChange}
            onClick={() => handleEdit("email")}
            disabled={!isEditing.email}
          />
          <TextField
            label="Nombre de posts supprimés"
            variant="outlined"
            fullWidth
            name="deletedPostsCount"
            value={values.deletedPostsCount}
            onChange={handleChange}
            onClick={() => handleEdit("deletedPostsCount")}
            disabled={!isEditing.deletedPostsCount}
          />
          <TextField
            label="Date de ban"
            variant="outlined"
            fullWidth
            name="banDate"
            value={values.banDate}
            onChange={handleChange}
            onClick={() => handleEdit("banDate")}
            disabled={!isEditing.banDate}
          />
          <TextField
            label="Date de création du compte"
            variant="outlined"
            fullWidth
            name="accountCreationDate"
            value={values.accountCreationDate}
            onChange={handleChange}
            onClick={() => handleEdit("accountCreationDate")}
            disabled={!isEditing.accountCreationDate}
          />
          <TextField
            label="Date de modification du compte"
            variant="outlined"
            fullWidth
            name="lastModificationDate"
            value={values.lastModificationDate}
            onChange={handleChange}
            onClick={() => handleEdit("lastModificationDate")}
            disabled={!isEditing.lastModificationDate}
          />
        </div>

        {/* Bouton Enregistrer */}
        <div className="flex flex-row justify-end space-x-4 mt-8">
          {/* <Button
            variant="contained"
            disabled={!isModified}
            startIcon={<Save />}
            onClick={handleReset}
          >
            Enregistrer
          </Button> */}

          {/* Bouton Supprimer */}
          <Button
            variant="outlined"
            onClick={handleDelete}
            color="error"
            startIcon={<Delete />}
          >
            Supprimer
          </Button>
        </div>
      </main>
    </div>
  );
};

export default UserEditEmbeddedPage;
