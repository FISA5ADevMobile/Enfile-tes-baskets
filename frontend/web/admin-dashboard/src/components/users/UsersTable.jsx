import { useState, useEffect, useContext } from "react";
import DataGridComponent from "./../common/DataGridComponent";
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
import { mapUserForDataGrid } from "../../utils/mapping";

const columns = [
  {
    field: "id",
    headerName: "ID",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
  },
  {
    field: "pseudo",
    headerName: "Pseudo",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "fullName",
    headerName: "Nom complet",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "email",
    headerName: "Email",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "role",
    headerName: "Rôle",
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
            window.location.href = `/utilisateurs/${id}`;
          }}
        />,
      ];
    },
  },
];

const rows = [
  {
    id: 1,
    pseudo: "jsnow",
    fullName: "John Snow",
    email: "john@example.com",
    role: "Admin",
  },
  {
    id: 2,
    pseudo: "zzcer",
    fullName: "Jaime Lannister",
    email: "jane@example.com",
    role: "Customer",
  },
  {
    id: 3,
    pseudo: "lann",
    fullName: "Cersei Lannister",
    email: "bob@example.com",
    role: "Admin",
  },
  {
    id: 4,
    pseudo: "aryaS",
    fullName: "Arya Stark",
    email: "alice@example.com",
    role: "Customer",
  },
  {
    id: 5,
    pseudo: "daen",
    fullName: "Daenerys Targaryen",
    email: "charlie@example.com",
    role: "Moderator",
  },
  {
    id: 6,
    pseudo: "mel",
    fullName: "Melisandre",
    email: "frank@example.com",
    role: "Admin",
  },
  {
    id: 7,
    pseudo: "cliff",
    fullName: "Richard Barron",
    email: "richard@example.com",
    role: "Customer",
  },
  {
    id: 8,
    pseudo: "ross",
    fullName: "James Ferrara",
    email: "james@example.com",
    role: "Admin",
  },
  {
    id: 9,
    pseudo: "rrooo",
    fullName: "Julie Ferrara",
    email: "julie@example.com",
    role: "Admin",
  },
];

const UsersTable = () => {
  const [usersData, setUsersData] = useState([]); // to uncomment during the integration
  // const [usersData, setUsersData] = useState(rows.map(mapUserForDataGrid)); //to comment during the integration

  const { userService } = useContext(AppContext);

  // to uncomment during the integration

  const getAllUsers = async () => {
    const response = await userService.getAllUsers();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      const users = response.data;
      setUsersData(
        users
          .map(mapUserForDataGrid)
          .filter(
            (user) =>
              !(
                user.fullName.includes("deleted_") &&
                user.email.includes("deleted_") &&
                user.pseudo.includes("deleted_")
              )
          )
      );
    }
  };

  useEffect(() => {
    getAllUsers();
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
          rows={usersData}
          columns={columns}
        />
      </div>
    </motion.div>
  );
};
export default UsersTable;
