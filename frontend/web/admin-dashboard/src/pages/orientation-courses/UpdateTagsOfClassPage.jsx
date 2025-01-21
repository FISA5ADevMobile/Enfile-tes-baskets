import React, { useState, useContext, useEffect } from "react";
import { TextField, Button, Checkbox, Autocomplete } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Delete, Edit, LockOpen, Save } from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";
import { se } from "date-fns/locale";
import { set } from "date-fns";

const UpdateTagsOfClassPage = () => {
  const { classId } = useParams();
  const navigate = useNavigate();

  const { orientationCourseService } = useContext(AppContext);
  // Default values
  const defaultValues = {
    selectedTags: [],
  };

  // States
  const [values, setValues] = useState(defaultValues);
  const [isEditing, setIsEditing] = useState(false);
  const [isModified, setIsModified] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const [allTags, setAllTags] = useState(null);
  const [theClass, setTheClass] = useState(null);
  const [classTags, setClassTags] = useState(null);

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

  const getTagsFromClass = async () => {
    const response = await orientationCourseService.getTagsFromClass(classId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    setValues({ ...values, selectedTags: response.data });
    setClassTags(response.data);
  };

  const deleteTagsFromClass = async () => {
    const classTagIds = classTags.map((tag) => tag.id);
    if (classTagIds.length === 0) {
      // console.log("No tags to delete");
      // dispatchToast("error", "Aucune balise à supprimer");
      return;
    }
    const response = await orientationCourseService.deleteTagsFromClass(
      classId,
      classTagIds
    );
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);

      return;
    }
  };

  const getAllTags = async () => {
    const response = await orientationCourseService.getAllTags();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    setAllTags(response.data);
  };

  const getClassById = async () => {
    const response = await orientationCourseService.getClassById(classId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }

    setTheClass(response.data);
  };

  const handleUpdateClassTags = async () => {
    setIsLoading(true);
    const deleteTagsResponse = await deleteTagsFromClass().then(async () => {
      const valuesClassTagIds = values.selectedTags.map((tag) => tag.id);
      if (valuesClassTagIds.length === 0 && classTags.length === 0) {
        // console.log("No tags to add");
        dispatchToast(
          "error",
          "Aucune balise lors de la mise à jour des balises"
        );
        return;
      }
      if (valuesClassTagIds.length === 0 && classTags.length === 1) {
        console.log("No tags to add");
        dispatchToast("success", "Balises de la classe mises à jour");
        return;
      }
      const response = await orientationCourseService.addTagsToClass(
        classId,
        valuesClassTagIds
      );

      if (response.error) {
        console.error(response.message);
        dispatchToast("error", response.message);
        return;
      }
      dispatchToast("success", "Balises de la classe mises à jour");
    });
    setIsLoading(false);
    getTagsFromClass();
  };

  useEffect(() => {
    getAllTags();
    getClassById();
    getTagsFromClass();
    Promise.all([getAllTags(), getClassById(), getTagsFromClass()]);
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Mise à jour des balises / ${classId}`} />

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

        <div className="text-2xl font-semibold mt-4 mb-4">
          {" "}
          Nom de la classe : {theClass?.name}
        </div>
        <div
          className="grid grid-cols-1 gap-4 p-8"
          style={{
            backgroundColor: "#18212F",
            borderRadius: "16px",
          }}
        >
          <Autocomplete
            // disablePortal
            id="combo-box-demo"
            options={allTags ?? []}
            fullWidth
            disableCloseOnSelect
            renderInput={(params) => (
              <TextField
                {...params}
                label="Balises"
              />
            )}
            onChange={(event, newValue) => {
              setValues({ ...values, selectedTags: newValue });
            }}
            isOptionEqualToValue={(option, value) => option.id === value.id}
            multiple
            value={values.selectedTags}
            getOptionLabel={(option) => `[${option.id}] ${option.name}`}
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
                onClick={handleUpdateClassTags}
                startIcon={<Save />}
              >
                Enregistrer
              </Button>
            </>
          )}
        </div>
      </main>
    </div>
  );
};

export default UpdateTagsOfClassPage;
