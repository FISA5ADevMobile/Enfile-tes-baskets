import React, { useState, useContext, useEffect } from "react";
import { TextField, Button } from "@mui/material";
import Header from "../../components/common/Header";
import { Add, Block, Delete, Edit, LockOpen, Save } from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import {
  dispatchToast,
  handleFormatBoolean,
  handleFormatDateTime,
} from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";

const CommunityEditEmbeddedPage = () => {
  const { communityId } = useParams();
  const navigate = useNavigate();

  const { communityService, categoryService } = useContext(AppContext);
  // Default values
  const defaultValues = {
    id: "",
    name: "",
    description: "",
    isPublic: handleFormatBoolean(false),
    categoryId: "",
    banDate: "",
    categoryName: "",
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

  // Fonction pour la suppression de la communauté (exemple simple)
  const handleDelete = async () => {
    setIsLoading(true);
    const response = await communityService.deleteCommunityById(communityId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    handleReset();
    console.log("Suppression de la communauté");
    dispatchToast("success", "Suppression de la communauté");
    setTimeout(() => {
      navigate("/communautes");
    }, 2000);
  };

  const getCommunityById = async () => {
    const response = await communityService.getCommunityById(communityId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const community = response.data;
    setValues({
      id: community.id,
      name: community.name,
      description: community.description,
      isPublic: community.isPublic ? "Oui" : "Non",
      categoryId: community.categoryId,
      banDate: handleFormatDateTime(new Date(community.banDate)),
      //
      //   nbModerators: community.moderators.length,
      //   nbUsers: community.users.length,
      //   nbPosts: community.posts.length,
      //   nbBannedUsers: community.bannedUsers.length,
      //   admin: `${community.admin.firstName} ${community.admin.lastName}`,
    });
  };

  const getCategoryById = async () => {
    if (!values.categoryId) {
      return;
    }
    const response = await categoryService.getCategoryById(values.categoryId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const category = response.data;
    setValues({ ...values, categoryName: category.name });
  };

  useEffect(() => {
    getCommunityById().then(() => {
      getCategoryById();
    });
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Communautés / ${communityId}`} />

      <main className="max-w-4xl mx-auto py-6 px-4 lg:px-8">
        <div className="flex justify-end mb-4 space-x-4">
          {!isLoading && (
            <>
              <Link to="/nouvelle-communaute">
                <Button
                  variant="text"
                  startIcon={<Add />}
                >
                  Créer une nouvelle
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
            label="Nom"
            variant="outlined"
            fullWidth
            name="name"
            value={values.description}
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
          <TextField
            label="Est publique ?"
            variant="outlined"
            fullWidth
            name="isPublic"
            value={values.isPublic}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="ID Categorie"
            variant="outlined"
            fullWidth
            name="category"
            value={values.categoryId}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Categorie"
            variant="outlined"
            fullWidth
            name="categoryName"
            value={values.categoryName}
            onChange={handleChange}
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

export default CommunityEditEmbeddedPage;
