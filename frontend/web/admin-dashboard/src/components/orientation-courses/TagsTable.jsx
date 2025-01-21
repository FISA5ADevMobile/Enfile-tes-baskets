import { useState, useEffect, useContext } from "react";
import DataGridComponent from "../common/DataGridComponent";
import { GridActionsCellItem } from "@mui/x-data-grid";
import SaveIcon from "@mui/icons-material/Save";
import CancelIcon from "@mui/icons-material/Close";
import DeleteIcon from "@mui/icons-material/DeleteOutlined";
import EditIcon from "@mui/icons-material/Edit";
import { PanoramaFishEye, RemoveRedEye } from "@mui/icons-material";
import { motion } from "framer-motion";
import { Search } from "lucide-react";
import { AppContext } from "../../services/context/AppContext";

import { DATA_GRID_COLUMN_DEFAULT_WIDTH } from "../../utils/constants";
import { ToastContainer, toast } from "react-toastify";
import { dispatchToast } from "../../utils/helper";
import { mapTagForDataGrid, mapUserForDataGrid } from "../../utils/mapping";

const columns = [
  {
    field: "id",
    headerName: "ID",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
  },
  {
    field: "name",
    headerName: "Nom",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "description",
    headerName: "Description",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  // {
  //   field: "ownerPseudo",
  //   headerName: "Pseudo propriétaire",
  //   width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
  //   editable: false,
  // },
  {
    field: "actions",
    type: "actions",
    headerName: "Actions",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    cellClassName: "actions",
    getActions: ({ id, row }) => {
      return [
        <GridActionsCellItem
          icon={<RemoveRedEye color="success" />}
          label="Voir"
          //showInMenu
          onClick={() => {
            console.log("id : " + id);
            console.log("row : " + JSON.stringify(row));
            window.location.href = `/parcours-orientation/balises/${id}`;
          }}
        />,
      ];
    },
  },
];

const rows = [
  {
    id: 1,
    name: "Tag 1",
    description: "Description 1",
    ownerPseudo: "Pseudo 1",
  },
  {
    id: 2,
    name: "Tag 2",
    description: "Description 2",
    ownerPseudo: "Pseudo 2",
  },
  {
    id: 3,
    name: "Tag 3",
    description: "Description 3",
    ownerPseudo: "Pseudo 3",
  },
  {
    id: 4,
    name: "Tag 4",
    description: "Description 4",
    ownerPseudo: "Pseudo 4",
  },
  {
    id: 5,
    name: "Tag 5",
    description: "Description 5",
    ownerPseudo: "Pseudo 5",
  },
];

const TagsTable = () => {
  const [tagsData, setTagsData] = useState([]); // to uncomment during the integration
  // const [tagsData, setTagsData] = useState(rows); //to comment during the integration

  const { orientationCourseService } = useContext(AppContext);

  // to uncomment during the integration

  const getAllTags = async () => {
    const response = await orientationCourseService.getAllTags();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      const tags = response.data;
      setTagsData(tags.map(mapTagForDataGrid));
    }
  };

  useEffect(() => {
    getAllTags();
  }, []);

  return (
    <motion.div
      // className="bg-gray-800 bg-opacity-50 backdrop-blur-md shadow-lg rounded-xl p-6 border border-gray-700"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: 0.2 }}
    >
      <ToastContainer />
      <div>
        <DataGridComponent
          rows={tagsData}
          columns={columns}
        />
      </div>
    </motion.div>
  );
};
export default TagsTable;
