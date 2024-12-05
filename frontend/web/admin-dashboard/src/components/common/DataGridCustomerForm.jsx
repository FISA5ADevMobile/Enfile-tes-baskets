// import DataGridComponent from "./DataGrid";
import { GridActionsCellItem } from "@mui/x-data-grid";
import SaveIcon from "@mui/icons-material/Save";
import CancelIcon from "@mui/icons-material/Close";
import DeleteIcon from "@mui/icons-material/DeleteOutlined";
import EditIcon from "@mui/icons-material/Edit";
import { PanoramaFishEye, RemoveRedEye } from "@mui/icons-material";
import DataGridComponent from "./DataGridComponent";
import { DATA_GRID_COLUMN_DEFAULT_WIDTH } from "../../utils/constants";

const columns = [
  {
    field: "id",
    headerName: "ID",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
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
    field: "age",
    headerName: "Age",
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
          label="View"
          className="textPrimary"
          onClick={() => {
            console.log("id : " + id);
            console.log("row : " + JSON.stringify(row));
          }}
          color="inherit"
        />,
        <GridActionsCellItem
          icon={<EditIcon color="warning" />}
          label="Modifier"
          onClick={() => (window.location.href = `/customer-form-inputs`)}
          color="inherit"
        />,
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

export default function DataGridCustomerForm(props) {
  return (
    <div>
      <DataGridComponent
        handleDelete={(selected) => {
          console.log(selected);
        }}
        handleAdd={() => (window.location.href = `/customer-form-inputs`)}
        rows={props.rows}
        columns={columns}
      />
    </div>
  );
}
