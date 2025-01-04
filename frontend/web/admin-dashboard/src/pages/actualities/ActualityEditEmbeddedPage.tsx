import React, { useState, useContext, useEffect } from "react";
import { TextField, Button, Checkbox } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Delete, Edit, LockOpen, Save } from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";

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
    }

    handleReset();
    console.log("Suppression de l'actualité");
    dispatchToast("success", "Actualité supprimée");
    setTimeout(() => {
      navigate("/actualites");
    }, 2000);
  };

  const getActualityById = async () => {
    const response = await actualityService.getActualityById(actualityId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const user = response.data;
    setValues({
      id: user.id,
      title: user.title,
      description: user.description,
      event: user.event,
      image: user.image,
      publicationDate: handleFormatDateTime(new Date(user.publicationDate)),
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
