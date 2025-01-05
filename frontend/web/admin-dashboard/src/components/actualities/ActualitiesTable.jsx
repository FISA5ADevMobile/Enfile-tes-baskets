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
import { mapActualityForDataGrid } from "../../utils/mapping";

const columns = [
  {
    field: "id",
    headerName: "ID",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
  },
  {
    field: "title",
    headerName: "Titre",
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
    field: "event",
    headerName: "Evènement",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "publicationDate",
    headerName: "Publiée le",
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
            window.location.href = `/actualites/${id}`;
          }}
        />,
      ];
    },
  },
];

const rows = [
  {
    id: 1,
    title: "Actualité 1",
    description: "Description de l'actualité 1",
    event: true,
    publicationDate: "2023-01-01",
  },
  {
    id: 2,
    title: "Actualité 2",
    description: "Description de l'actualité 2",
    event: false,
    publicationDate: "2023-02-01",
  },
  {
    id: 3,
    title: "Actualité 3",
    description: "Description de l'actualité 3",
    event: true,
    publicationDate: "2023-03-01",
  },
  {
    id: 4,
    title: "Actualité 4",
    description: "Description de l'actualité 4",
    event: false,
    publicationDate: "2023-04-01",
  },
  {
    id: 5,
    title: "Actualité 5",
    description: "Description de l'actualité 5",
    event: true,
    publicationDate: "2023-05-01",
  },
];

const ActualitiesTable = () => {
  const [actualitiesData, setActualitiesData] = useState([]); // to uncomment during the integration
  // const [actualitiesData, setActualitiesData] = useState(
  //   rows.map(mapActualityForDataGrid)
  // ); //to comment during the integration

  const { actualityService } = useContext(AppContext);

  const getAllActualities = async () => {
    const response = await actualityService.getAllActualities();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      const users = response.data;
      setActualitiesData(users.map(mapActualityForDataGrid));
    }
  };

  useEffect(() => {
    getAllActualities();
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
          rows={actualitiesData}
          columns={columns}
        />
      </div>
    </motion.div>
  );
};
export default ActualitiesTable;
