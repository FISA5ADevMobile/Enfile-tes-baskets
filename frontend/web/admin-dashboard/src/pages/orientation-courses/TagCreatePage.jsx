import React, { useState, useContext } from "react";
import { TextField, Button, Checkbox } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Delete, Edit, Save } from "@mui/icons-material";
import { Link, useParams } from "react-router-dom";
import { AppContext } from "../../services/context/AppContext";
import { CircularProgress } from "@mui/material";
import { dispatchToast, handleFormatDateTime } from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";

const TagCreatePage = () => {
  const { orientationCourseService } = useContext(AppContext);

  // Default values
  const defaultValues = {
    name: "",
    description: "",
  };

  // States
  const [values, setValues] = useState(defaultValues);
  const [isLoading, setIsLoading] = useState(false);

  // Function for handling input changes
  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues({ ...values, [name]: value });
  };

  // Fonction pour réinitialiser les changements
  const handleReset = () => {
    setValues(defaultValues);
  };

  const handleCreate = async () => {
    setIsLoading(true);
    const response = await orientationCourseService.createTag({
      name: values.name,
      description: values.description,
    });
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", "Balise créée");
    handleReset();
  };

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Nouvelle balise`} />

      <main className="max-w-4xl mx-auto py-6 px-4 lg:px-8">
        <div
          className="grid grid-cols-1 gap-4 p-8"
          style={{
            backgroundColor: "#18212F",
            borderRadius: "16px",
          }}
        >
          <TextField
            label="Nom de la balise"
            variant="outlined"
            fullWidth
            name="name"
            value={values.name}
            onChange={handleChange}
          />
          <TextField
            label="Description"
            variant="outlined"
            fullWidth
            name="description"
            value={values.description}
            multiline
            onChange={handleChange}
          />
        </div>

        <ToastContainer />
        {/* Bouton Enregistrer */}
        <div className="flex flex-row justify-end space-x-4 mt-8">
          {isLoading ? (
            <CircularProgress />
          ) : (
            <Button
              variant="contained"
              disabled={!values.name || !values.description}
              startIcon={<Add />}
              onClick={handleCreate}
            >
              Créer
            </Button>
          )}
        </div>
      </main>
    </div>
  );
};

export default TagCreatePage;
