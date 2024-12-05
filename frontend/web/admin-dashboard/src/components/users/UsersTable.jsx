import { useState } from "react";
import DataGridComponent from "./../common/DataGridComponent";
import { GridActionsCellItem } from "@mui/x-data-grid";
import SaveIcon from "@mui/icons-material/Save";
import CancelIcon from "@mui/icons-material/Close";
import DeleteIcon from "@mui/icons-material/DeleteOutlined";
import EditIcon from "@mui/icons-material/Edit";
import { PanoramaFishEye, RemoveRedEye } from "@mui/icons-material";
import { motion } from "framer-motion";
import { Search } from "lucide-react";

import { DATA_GRID_COLUMN_DEFAULT_WIDTH } from "../../utils/constants";

const userData = [
  {
    id: 1,
    name: "John Doe",
    email: "john@example.com",
    role: "Customer",
    status: "Active",
  },
  {
    id: 2,
    name: "Jane Smith",
    email: "jane@example.com",
    role: "Admin",
    status: "Active",
  },
  {
    id: 3,
    name: "Bob Johnson",
    email: "bob@example.com",
    role: "Customer",
    status: "Inactive",
  },
  {
    id: 4,
    name: "Alice Brown",
    email: "alice@example.com",
    role: "Customer",
    status: "Active",
  },
  {
    id: 5,
    name: "Charlie Wilson",
    email: "charlie@example.com",
    role: "Moderator",
    status: "Active",
  },
];

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
    field: "lastName",
    headerName: "Nom",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "firstName",
    headerName: "Prénom",
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
    field: "actions",
    type: "actions",
    headerName: "Actions",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    cellClassName: "actions",
    getActions: ({ id, row }) => {
      //const isInEditMode = rowModesModel[id]?.mode === GridRowModes.Edit;
      // const isInEditMode = false;
      // if (isInEditMode) {
      //   return [
      //     <GridActionsCellItem
      //       icon={<SaveIcon />}
      //       label="Save"
      //       sx={{
      //         color: "primary.main",
      //       }}
      //       onClick={() => id}
      //     />,
      //     <GridActionsCellItem
      //       icon={<CancelIcon />}
      //       label="Cancel"
      //       className="textPrimary"
      //       onClick={() => id}
      //       color="inherit"
      //     />,
      //   ];
      // }

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
        // <GridActionsCellItem
        //   icon={<EditIcon color="warning" />}
        //   label="Modifier"
        //   onClick={() => (window.location.href = `/customer-form-inputs`)}
        //   color="inherit"
        // />,
        // <GridActionsCellItem
        //   icon={<DeleteIcon color="error" />}
        //   label="Delete"
        //   onClick={() => id}
        //   color="inherit"
        // />,
      ];
    },
  },
];

const rows = [
  {
    id: 1,
    pseudo: "jsnow",
    lastName: "Snow",
    firstName: "Jon",
    email: "john@example.com",
  },
  {
    id: 2,
    pseudo: "zzcer",
    lastName: "Lannister",
    firstName: "Cersei",
    email: "jane@example.com",
  },
  {
    id: 3,
    pseudo: "lann",
    lastName: "Lannister",
    firstName: "Jaime",
    email: "bob@example.com",
  },
  {
    id: 4,
    pseudo: "aryaS",
    lastName: "Stark",
    firstName: "Arya",
    email: "alice@example.com",
  },
  {
    id: 5,
    pseudo: "daen",
    lastName: "Targaryen",
    firstName: "Daenerys",
    email: "charlie@example.com",
  },
  {
    id: 6,
    pseudo: "mel",
    lastName: "Melisandre",
    firstName: null,
    email: "frank@example.com",
  },
  {
    id: 7,
    pseudo: "cliff",
    lastName: "Clifford",
    firstName: "Ferrara",
    email: "richard@example.com",
  },
  {
    id: 8,
    pseudo: "ross",
    lastName: "Frances",
    firstName: "Rossini",
    email: "james@example.com",
  },
  {
    id: 9,
    pseudo: "rrooo",
    lastName: "Roxie",
    firstName: "Harvey",
    email: "julie@example.com",
  },
];

const UsersTable = () => {
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredUsers, setFilteredUsers] = useState(userData);

  const handleSearch = (e) => {
    const term = e.target.value.toLowerCase();
    setSearchTerm(term);
    const filtered = userData.filter(
      (user) =>
        user.name.toLowerCase().includes(term) ||
        user.email.toLowerCase().includes(term)
    );
    setFilteredUsers(filtered);
  };

  return (
    <motion.div
      // className="bg-gray-800 bg-opacity-50 backdrop-blur-md shadow-lg rounded-xl p-6 border border-gray-700"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: 0.2 }}
    >
      <div>
        <DataGridComponent
          rows={rows}
          columns={columns}
        />
      </div>
    </motion.div>
  );
};
export default UsersTable;
