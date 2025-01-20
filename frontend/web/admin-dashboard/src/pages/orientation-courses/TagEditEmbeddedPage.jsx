import React, { useState, useContext, useEffect } from "react";
import { TextField, Button, Checkbox } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Cancel, Delete, Edit, LockOpen, Save } from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";
import { TIMEOUT_REFRESH } from "../../utils/constants";

const TagEditEmbeddedPage = () => {
  const { tagId } = useParams();
  const navigate = useNavigate();

  const { orientationCourseService } = useContext(AppContext);
  // Default values
  const defaultValues = {
    id: "",
    name: "",
    description: "",
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
    const response = await orientationCourseService.deleteTagById(tagId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    }

    handleReset();
    console.log("Suppression de la balise");
    dispatchToast("success", "Balise supprimée");
    setTimeout(() => {
      navigate("/parcours-orientation");
    }, TIMEOUT_REFRESH);
  };

  const getTagById = async () => {
    const response = await orientationCourseService.getTagById(tagId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const tag = response.data;
    setValues({
      id: tag.id,
      name: tag.name,
      description: tag.description,
    });
  };

  const handleCancelEdit = () => {
    setIsEditing(false);
    handleReset();
    getTagById();
  };

  const handleUpdate = async () => {
    setIsLoading(true);
    const response = await orientationCourseService.updateTagById(
      tagId,
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
    getTagById();
  };

  useEffect(() => {
    getTagById();
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Balises / ${tagId}`} />

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

              <Link to="/nouvelle-balise">
                <Button
                  variant="text"
                  startIcon={<Add />}
                >
                  Créer une nouvelle balise
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
            label="Nom de la balise"
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
        </div>

        <ToastContainer />
        {/* Bouton Enregistrer */}
        <div className="flex flex-row justify-end space-x-4 mt-8">
          {isLoading ? (
            <CircularProgress />
          ) : (
            <>
              {isModified && isEditing && (
                <Button
                  variant="outlined"
                  onClick={handleCancelEdit}
                  startIcon={<Cancel />}
                >
                  Annuler
                </Button>
              )}
              {isModified && isEditing && (
                <Button
                  variant="outlined"
                  onClick={handleUpdate}
                  startIcon={<Save />}
                >
                  Enregistrer
                </Button>
              )}

              {/* <Button
                variant="outlined"
                onClick={handleDelete}
                color="error"
                startIcon={<Delete />}
              >
                Supprimer
              </Button> */}
            </>
          )}
        </div>
      </main>
    </div>
  );
};

export default TagEditEmbeddedPage;
