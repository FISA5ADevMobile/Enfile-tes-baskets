import React, { useState, useContext, useEffect } from "react";
import { TextField, Button, Checkbox, InputAdornment } from "@mui/material";
import Header from "../../components/common/Header";
import {
  Add,
  Cancel,
  Delete,
  Edit,
  LockOpen,
  Save,
  Visibility,
} from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";
import { Edit2 } from "lucide-react";
import { TIMEOUT_REFRESH } from "../../utils/constants";

const ClassEditEmbeddedPage = () => {
  const { classId } = useParams();
  const navigate = useNavigate();

  const { orientationCourseService } = useContext(AppContext);
  // Default values
  const defaultValues = {
    id: "",
    name: "",
    description: "",
    password: "",
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

  // Fonction pour la suppression de la balise (exemple simple)
  const handleDelete = async () => {
    setIsLoading(true);
    const response = await orientationCourseService.deleteClassById(classId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    }

    handleReset();
    console.log("Suppression de la classe");
    dispatchToast("success", "Classe supprimée");
    setTimeout(() => {
      navigate("/parcours-orientation");
    }, TIMEOUT_REFRESH);
  };

  const getClassById = async () => {
    const response = await orientationCourseService.getClassById(classId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const aClass = response.data;
    setValues({
      id: aClass.id,
      name: aClass.name,
      description: aClass.description,
      password: aClass.password,
    });
  };

  const handleCancelEditing = async () => {
    handleReset();
    setIsEditing(false);
    getClassById();
  };

  const handleSave = async () => {
    setIsLoading(true);
    const response = await orientationCourseService.updateClassById(
      classId,
      values
    );
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", "Modifications enregistrées");
    setIsEditing(false);
    getClassById();
  };

  useEffect(() => {
    getClassById();
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Classes / ${classId}`} />

      <main className="max-w-4xl mx-auto py-6 px-4 lg:px-8">
        <div className="flex justify-end mb-4 space-x-4">
          {!isLoading && (
            <>
              <Button
                variant="text"
                startIcon={<Edit />}
                onClick={() => setIsEditing(!isEditing)}
              >
                Modifier
              </Button>

              <Link to="/nouvelle-classe">
                <Button
                  variant="text"
                  startIcon={<Add />}
                >
                  Créer une nouvelle classe
                </Button>
              </Link>
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
            label="Nom de la classe"
            variant="outlined"
            fullWidth
            name="name"
            value={values.name}
            onChange={handleChange}
            disabled={!isEditing}
          />
          <TextField
            label="Description"
            variant="outlined"
            fullWidth
            name="description"
            value={values.description}
            onChange={handleChange}
            disabled={!isEditing}
          />
          <TextField
            label="Mot de passe"
            variant="outlined"
            fullWidth
            name="password"
            autoComplete="new-password"
            value={values.password}
            onChange={handleChange}
            disabled={!isEditing}
          />
        </div>

        <ToastContainer />
        {/* Bouton Enregistrer */}
        <div className="flex flex-row justify-end space-x-4 mt-8">
          {isLoading ? (
            <CircularProgress />
          ) : (
            <>
              {/* Boutons */}

              {isEditing && (
                <>
                  <Button
                    variant="outlined"
                    onClick={handleCancelEditing}
                    startIcon={<Cancel />}
                  >
                    Annuler
                  </Button>
                  <Button
                    variant="contained"
                    onClick={handleSave}
                    startIcon={<Save />}
                  >
                    Enregistrer
                  </Button>
                </>
              )}

              <Button
                variant="outlined"
                onClick={() => {
                  navigate(
                    `/parcours-orientation/mettre-a-jour-balises-classe/${classId}`
                  );
                }}
                startIcon={<Edit />}
                disabled={isModified}
              >
                Mettre à jour les balises
              </Button>
              <Button
                variant="outlined"
                onClick={handleDelete}
                color="error"
                startIcon={<Delete />}
                disabled={isModified}
              >
                Supprimer la classe
              </Button>
            </>
          )}
        </div>
      </main>
    </div>
  );
};

export default ClassEditEmbeddedPage;
