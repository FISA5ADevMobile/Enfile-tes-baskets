import React from 'react';

import config from '../config/index.json';

const MainHero = () => {
  const { mainHero } = config;

  const apkDownloadUrl = process.env.NEXT_PUBLIC_APK_DOWNLOAD_URL;
  const testFlightUrl = process.env.NEXT_PUBLIC_TEST_FLIGHT_URL;
  return (
    <main className="mt-10 mx-auto max-w-7xl px-4 sm:mt-12 sm:px-6 md:mt-16 lg:mt-20 lg:px-8 xl:mt-28">
      <div className="sm:text-center lg:text-left">
        <h1 className="text-4xl tracking-tight font-extrabold text-gray-900 sm:text-5xl md:text-5xl">
          <span className="block xl:inline">{mainHero.title}</span>{' '}
          <span className={`block text-primary xl:inline`}>
            {mainHero.subtitle}
          </span>
        </h1>
        <p className="mt-3 text-base text-gray-500 sm:mt-5 sm:text-lg sm:max-w-xl sm:mx-auto md:mt-5 md:text-xl lg:mx-0">
          {mainHero.description}
        </p>
        <div className="mt-5 sm:mt-8 sm:flex sm:justify-center lg:justify-start">
          <div className="rounded-md shadow">
            <a
              className={`w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-background bg-primary hover:bg-border hover:text-primary md:py-4 md:text-lg md:px-10`}
              href={apkDownloadUrl ?? mainHero.primaryAction.href} // Le lien vers le fichier APK
              // download={
              //   mainHero.primaryAction.isDownloadable ? 'etb.apk' : false
              // } // Téléchargement si disponible
              onClick={(e) => {
                if (!apkDownloadUrl) {
                  e.preventDefault(); // Empêche l'action par défaut
                  alert('Pas encore disponible !');
                }
              }}
              target="_blank"
            >
              {mainHero.primaryAction.text}
            </a>
          </div>
          <div className="mt-3 sm:mt-0 sm:ml-3">
            <a
              href={testFlightUrl ?? mainHero.secondaryAction.href}
              onClick={(e) => {
                if (!testFlightUrl) {
                  e.preventDefault(); // Empêche l'action par défaut
                  alert('Pas encore disponible !');
                }
              }}
              target="_blank"
              className={`w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md border-primary text-primary bg-background hover:bg-border hover:text-primary md:py-4 md:text-lg md:px-10`}
            >
              {mainHero.secondaryAction.text}
            </a>
          </div>
        </div>
      </div>
    </main>
  );
};

export default MainHero;
