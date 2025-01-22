import { HelpCircle, LifeBuoy, Lock } from "lucide-react";
import SettingSection from "./SettingSection";
import ToggleSwitch from "./ToggleSwitch";
import { useState } from "react";
import { Link } from "react-router-dom";

const Guide = () => {
  return (
    <SettingSection
      icon={LifeBuoy}
      title={"Aide : Comment utiliser l'Admin Dashboard ?"}
    >
      <div className="mt-4">
        <Link to="/aide">
          <button
            className="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded 
        transition duration-200
        "
          >
            Manuel d'utilisation
          </button>
        </Link>
      </div>
    </SettingSection>
  );
};
export default Guide;
