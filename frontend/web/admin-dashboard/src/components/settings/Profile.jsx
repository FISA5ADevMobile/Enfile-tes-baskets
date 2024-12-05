import { User } from "lucide-react";
import SettingSection from "./SettingSection";

const Profile = () => {
  return (
    <SettingSection
      icon={User}
      title={"Profil"}
    >
      <div className="flex flex-col sm:flex-row items-center mb-6">
        <img
          src="/images/pape.jpeg"
          alt="Profil"
          className="rounded-full w-20 h-20 object-cover mr-4"
        />

        <div>
          <h3 className="text-lg font-semibold text-gray-100">Pape THIAM</h3>
          <p className="text-gray-400">pape.thiam@enfiletesbaskets.com</p>
        </div>
      </div>
      <div className="flex flex-col sm:flex-row gap-4">
        <button className="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded transition duration-200 w-full sm:w-auto">
          Modifier le profil
        </button>
        <button
          className="bg-orange-600 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded transition duration-200 w-full sm:w-auto"
          onClick={() => {
            localStorage.removeItem("token");
            window.location.href = "/connexion";
          }}
        >
          Se déconnecter
        </button>
      </div>
    </SettingSection>
  );
};
export default Profile;
