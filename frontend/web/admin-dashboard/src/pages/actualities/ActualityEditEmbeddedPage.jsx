import React, { useState, useContext, useEffect } from "react";
import { TextField, Button, Checkbox } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Delete, Edit, LockOpen, Save } from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";
import { TIMEOUT_REFRESH } from "../../utils/constants";

const ActualityEditEmbeddedPage = () => {
  const { actualityId } = useParams();
  const navigate = useNavigate();

  const { actualityService } = useContext(AppContext);
  // Default values
  const defaultValues = {
    id: "",
    title: "",
    description: "",
    event: false,
    // imageFile: null, // Fichier brut
    image: null, // URL pour le preview or fichier brut
    publicationDate: "",
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

  // Fonction pour la suppression de l'actuality (exemple simple)
  const handleDelete = async () => {
    setIsLoading(true);
    const response = await actualityService.deleteActualityById(actualityId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }

    handleReset();
    console.log("Suppression de l'actualité");
    dispatchToast("success", "Actualité supprimée");
    setTimeout(() => {
      navigate("/actualites");
    }, TIMEOUT_REFRESH);
  };

  const getActualityById = async () => {
    const response = await actualityService.getActualityById(actualityId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const actuality = response.data;
    setValues({
      id: actuality.id,
      title: actuality.title,
      description: actuality.description,
      event: actuality.event,
      image: actuality.image,
      publicationDate: handleFormatDateTime(
        new Date(actuality.publicationDate)
      ),
    });
  };

  useEffect(() => {
    getActualityById();
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Actualités / ${actualityId}`} />

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
          {values.image && (
            <div className="flex items-center justify-center mb-6">
              {/* preview image base64 */}

              <img
                src={`data:image/png;base64,${values.image}`}
                alt={values.title}
                className="w-full h-full object-cover"
                style={{ borderRadius: "16px" }}
              />
            </div>
          )}
          <TextField
            label="ID"
            variant="outlined"
            fullWidth
            name="id"
            value={values.id}
            disabled
          />
          <TextField
            label="Titre"
            variant="outlined"
            fullWidth
            name="title"
            value={values.title}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Description"
            variant="outlined"
            fullWidth
            name="description"
            value={values.description}
            onChange={handleChange}
            disabled
          />
          <div className="flex items-center justify-start mb-6">
            <Checkbox
              color="primary"
              name="event"
              checked={values.event}
              onChange={(e) =>
                setValues({ ...values, event: e.target.checked })
              }
              disabled
            />
            <p className="text-white-600">C'est un evenement ?</p>
          </div>

          <TextField
            label="Publiée le"
            variant="outlined"
            fullWidth
            name="publicationDate"
            value={values.publicationDate}
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

export default ActualityEditEmbeddedPage;
