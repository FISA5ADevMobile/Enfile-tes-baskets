import { fr } from "date-fns/locale";
import { format } from "date-fns";
import { DATE_d_LLL_YYYY, DATE_TIME_d_LLL_YYYY } from "./constants";
import { toast } from "react-toastify";

export const handleFormatDate = (date) => {
    return format(date, DATE_d_LLL_YYYY, { locale: fr });
};

export const handleFormatDateTime = (date) => {
    return format(date, DATE_TIME_d_LLL_YYYY, { locale: fr });
};

export const dispatchToast = (type, message) => {
    toast[type](message, {
        style: {
            backgroundColor: "#374151",
            color: "white",
            borderWidth: "1px",
            borderColor: "white",
        },
    });
};

export const handleBooleanFormat = (value) => {
    return value ? "Oui" : "Non";
};