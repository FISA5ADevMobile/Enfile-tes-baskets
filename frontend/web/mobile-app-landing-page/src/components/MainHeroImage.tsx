import React from 'react';

import config from '../config/index.json';

const MainHeroImage = () => {
  const { mainHero } = config;
  return (
    // <div className="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2">
    <div className="lg:block lg:absolute lg:inset-y-0 lg:right-0  lg:w-1/2">
      <img
        className="h-96 w-full object-cover sm:h-full md:h-96 lg:w-full lg:h-full"
        src={mainHero.img}
        alt="happy team image"
      />
    </div>
  );
};

export default MainHeroImage;
