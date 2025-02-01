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
import {
  mapCommunityForDataGrid,
  mapUserForDataGrid,
} from "../../utils/mapping";

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
  {
    field: "isPublic",
    headerName: "Publique",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "categoryName",
    headerName: "Categorie",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
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
            window.location.href = `/communautes/${id}`;
          }}
        />,
      ];
    },
  },
];

const rows = [
  {
    id: 1,
    name: "Community 1",
    description: "Description 1",
    isPublic: true,
    categoryName: "Categorie 1",
  },
  {
    id: 2,
    name: "Community 2",
    description: "Description 2",
    isPublic: false,
    categoryName: "Categorie 2",
  },
  {
    id: 3,
    name: "Community 3",
    description: "Description 3",
    isPublic: true,
    categoryName: "Categorie 3",
  },
  {
    id: 4,
    name: "Community 4",
    description: "Description 4",
    isPublic: false,
    categoryName: "Categorie 4",
  },
  {
    id: 5,
    name: "Community 5",
    description: "Description 5",
    isPublic: true,
    categoryName: "Categorie 5",
  },
];

const CommunitiesTable = () => {
  const [communitiesData, setCommunitiesData] = useState([]); // to uncomment during the integration
  // const [communitiesData, setCommunitiesData] = useState(rows); //to comment during the integration

  const { communityService } = useContext(AppContext);

  // to uncomment during the integration

  const getAllCommunities = async () => {
    const response = await communityService.getAllCommunities();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      const communities = response.data;
      setCommunitiesData(communities.map(mapCommunityForDataGrid));
    }
  };

  useEffect(() => {
    getAllCommunities();
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
          rows={communitiesData}
          columns={columns}
        />
      </div>
    </motion.div>
  );
};
export default CommunitiesTable;
