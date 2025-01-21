import { User } from "lucide-react";
import SettingSection from "./SettingSection";
import { useContext, useState, useEffect } from "react";
import { AppContext } from "../../services/context/AppContext";
import { useNavigate } from "react-router-dom";
import { toast, ToastContainer } from "react-toastify";
import { dispatchToast } from "../../utils/helper";

const Profile = () => {
  const [currentUser, setCurrentUser] = useState(null);
  const { authService, userService } = useContext(AppContext);
  const navigate = useNavigate();

  const handleLogout = () => {
    authService.logout();
    navigate("/connexion");
  };

  const getCurrentUser = async () => {
    const response = await authService.getCurrentUser();
    if (response.error) {
      console.log(response.message);
      dispatchToast("error", response.message);
    } else {
      setCurrentUser(response.data);
    }
  };

  useEffect(() => {
    getCurrentUser();
  }, []);

  return (
    <SettingSection
      icon={User}
      title={"Profil"}
    >
      <ToastContainer />
      <div className="flex flex-col sm:flex-row items-center mb-6">
        <img
          src="/images/app-logo.png"
          alt="Profil"
          className="rounded-full w-20 h-20 object-cover mr-4"
        />

        <div>
          <h3 className="text-lg font-semibold text-gray-100">
            {currentUser
              ? `${currentUser?.firstName} ${currentUser?.name}`
              : "..."}
          </h3>
          <p className="text-gray-400">
            {currentUser ? currentUser.email : "..."}
          </p>
        </div>
      </div>
      <div className="flex flex-col sm:flex-row gap-4">
        {/* <button className="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded transition duration-200 w-full sm:w-auto">
          Modifier le profil
        </button> */}
        <button
          className="bg-orange-600 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded transition duration-200 w-full sm:w-auto"
          onClick={handleLogout}
        >
          Se déconnecter
        </button>
      </div>
    </SettingSection>
  );
};
export default Profile;
