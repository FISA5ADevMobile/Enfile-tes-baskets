import * as React from "react";
import Box from "@mui/material/Box";
import {
  DataGrid,
  GridToolbar,
  GridToolbarContainer,
  GridToolbarExport,
} from "@mui/x-data-grid";
import { Button } from "@mui/material";
import DeleteIcon from "@mui/icons-material/Delete";
import AddIcon from "@mui/icons-material/Add";

const customLocaleText = {
  // Root
  noRowsLabel: "Aucune ligne disponible.",
  noResultsOverlayLabel: "Aucun resultat trouvé.",

  toolbarDensity: "Taille",
  toolbarDensityLabel: "Taille",
  toolbarDensityCompact: "Petite",
  toolbarDensityStandard: "Moyenne",
  toolbarDensityComfortable: "Grande",
  toolbarColumns: "Colonnes",
  toolbarColumnsLabel: "Colonnes",
  toolbarExport: "Exporter",
  toolbarExportLabel: "Exporter",
  toolbarFilters: "Filtres",
  toolbarFiltersLabel: "Filtres",
  toolbarQuickFilterPlaceholder: "Recherche rapide",
  columnMenuFilter: "Filtrer",
  columnMenuFilterLabel: "Filtrer",
  columnMenuSort: "Trier",
  columnMenuSortLabel: "Trier",
  columnMenuSortAsc: "Trier par ordre croissant",
  columnMenuSortDesc: "Trier par ordre decroissant",
  columnMenuUnsort: "Trier par ordre normal",
  columnMenuUnsortLabel: "Trier par ordre normal",
  columnMenuHideColumn: "Cacher la colonne",
  columnMenuManageColumns: "Gérer les colonnes",
  columnMenuManageColumnsLabel: "Gérer les colonnes",
  columnMenuShowColumns: "Afficher les colonnes",
  columnMenuShowColumnsLabel: "Afficher les colonnes",

  // Columns management text
  columnsManagementSearchTitle: "Rechercher une colonne",
  columnsManagementNoColumns: "Pas de colonne disponible.",
  columnsManagementShowHideAllText: "Afficher/Cacher toutes",
  columnsManagementReset: "Reinitialiser",
  columnsManagementDeleteIconLabel: "Clear",

  // columnSear
  // filters translations
  filterPanelColumns: "Colonnes",
  filterPanelInputPlaceholder: "Valeur du filtre",
  filterPanelInputLabel: "Valeur",

  filterOperatorContains: "Contient",
  filterOperatorDoesNotContain: "Ne contient pas",
  filterOperatorEquals: "Est",
  filterOperatorDoesNotEqual: "N'est pas",
  filterOperatorArrayContains: "Contient",
  filterOperatorStartsWith: "Commence par",
  filterOperatorEndsWith: "Termine par",
  filterOperatorIsEmpty: "Est vide",
  filterOperatorIsNotEmpty: "N'est pas vide",
  filterOperatorIsAnyOf: "Est un parmi",

  footerRowSelected: (count) =>
    `${count} ${count === 1 ? "ligne sélectionnée" : "lignes sélectionnées"}`,
  footerTotalRows: (total) =>
    `Total ${total} ${total === 1 ? "ligne" : "lignes"}`,

  toolbarExportCSV: "Exporter en CSV",
  toolbarExportPrint: "Imprimer",
};

export default function DataGridComponent(props) {
  const [rowSelectionModel, setRowSelectionModel] = React.useState([]);

  const handleDelete = () => {
    /*if (props.type === 'customer') window.location.href=`/customer-inputs`;
        if (props.type === 'customerForm') window.location.href=`/customer-form-inputs`;*/
  };

  const handleAdd = () => {
    // props.handleAdd();
  };

  return (
    <>
      {/* <Box
        display="flex"
        justifyContent="center"
        alignItems="center"
        width="100%"
      >
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={handleAdd}
          sx={{ m: 2 }}
        >
          Ajouter
        </Button>
        <Button
          variant="contained"
          startIcon={<DeleteIcon />}
          onClick={handleDelete}
          color="error"
          sx={{ m: 2 }}
        >
          Supprimer
        </Button>
      </Box> */}

      <Box sx={{ height: 600, width: "100%" }}>
        <DataGrid
          rows={props.rows}
          columns={props.columns}
          initialState={{
            pagination: {
              paginationModel: {
                pageSize: 5,
              },
            },
          }}
          slots={{
            toolbar: GridToolbar,
          }}
          slotProps={{
            toolbar: {
              showQuickFilter: true,
            },
            pagination: {
              labelDisplayedRows: ({ from, to, count }) =>
                `${from}-${to} de ${count}`,
              labelRowsPerPage: "Lignes par page :",
            },
          }}
          pageSizeOptions={[5, 10, 25]}
          localeText={customLocaleText}
          // checkboxSelection
          onRowSelectionModelChange={(newRowSelectionModel) => {
            setRowSelectionModel(newRowSelectionModel);
          }}
          rowSelectionModel={rowSelectionModel}
          disableRowSelectionOnClick
          className="p-4"
        />
      </Box>
    </>
  );
}
