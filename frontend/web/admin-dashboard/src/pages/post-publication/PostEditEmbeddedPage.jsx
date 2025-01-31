import React, { useState, useContext, useEffect } from "react";
import { TextField, Button } from "@mui/material";
import Header from "../../components/common/Header";
import {
  Add,
  Block,
  Delete,
  Edit,
  HideImage,
  LockOpen,
  Save,
} from "@mui/icons-material";
import { Link, useNavigate, useParams } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import {
  dispatchToast,
  handleFormatBoolean,
  handleFormatDateTime,
} from "../../utils/helper";
import { ToastContainer, toast } from "react-toastify";
import { AppContext } from "../../services/context/AppContext";
import { TIMEOUT_REFRESH } from "../../utils/constants";
import { Eye, EyeOff } from "lucide-react";

const PostEditEmbeddedPage = () => {
  const { postId } = useParams();
  const navigate = useNavigate();

  const { postService } = useContext(AppContext);

  // Default values
  const defaultValues = {
    id: "",
    content: "",
    username: "",
    datePost: "",
    nbLike: 0,
    visible: false,
    image: "",
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

  // Fonction pour la suppression du post (exemple simple)
  const handleDelete = async () => {
    setIsLoading(true);
    const response = await postService.deletePostById(postId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    handleReset();
    console.log("Suppression du post");
    dispatchToast("success", "Post supprimé");
    setTimeout(() => {
      navigate("/posts");
    }, TIMEOUT_REFRESH);
  };

  const getPostById = async () => {
    const response = await postService.getPostById(postId);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    const post = response.data;
    setValues({
      id: post.id,
      content: post.content,
      username: post.username,
      datePost: handleFormatDateTime(new Date(post.datePost)),
      nbLike: post.nbLike ?? 0,
      visible: post.visible,
      image: post.image,
    });
  };

  const makeVisiblePost = async () => {
    setIsLoading(true);
    const response = await postService.makeVisiblePost(postId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", "Post est maintenant visible");
  };

  const makeInvisiblePost = async () => {
    setIsLoading(true);
    const response = await postService.makeInvisiblePost(postId);
    setIsLoading(false);
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
      return;
    }
    dispatchToast("success", "Post maintenant invisible");
    getPostById();
  };

  useEffect(() => {
    getPostById();
  }, []);

  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title={`Posts / ${postId}`} />

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
            label="Contenu"
            multiline
            variant="outlined"
            fullWidth
            name="content"
            value={values.content}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Username"
            variant="outlined"
            fullWidth
            name="creatorId"
            value={values.username}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Nombre de likes"
            variant="outlined"
            fullWidth
            name="nbLike"
            value={values.nbLike}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Date de publication"
            variant="outlined"
            fullWidth
            name="datePost"
            value={values.datePost}
            onChange={handleChange}
            disabled
          />
          <TextField
            label="Visibilité du post"
            variant="outlined"
            fullWidth
            name="visible"
            value={handleFormatBoolean(values.visible)}
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
              {/* <Button
                variant="outlined"
                onClick={handleDelete}
                color="error"
                startIcon={<Delete />}
              >
                Supprimer
              </Button> */}

              {values.visible && (
                <Button
                  variant="outlined"
                  onClick={makeInvisiblePost}
                  startIcon={<EyeOff />}
                >
                  Rendre invisible
                </Button>
              )}
            </>
          )}
        </div>
      </main>
    </div>
  );
};

export default PostEditEmbeddedPage;
