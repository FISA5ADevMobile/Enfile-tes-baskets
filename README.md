# <img src="readme-images/app-logo.png" width="32" /> Enfile-tes-baskets

Projet développement mobile enfile tes baskets

## 🌱 Backend : Spring Boot

### ⚙️ Environnements

Dans le projet backend spring, `3 environnements` ont été mis en place à savoir:

- `local` avec ses variables d'environnement dans le fichier `application-local.properties`, pour une base de données locale
- `dev` => `application-local.properties`, pour une base de données distante pour le développement
- `prod` => `application-prod.properties`, pour une base de donnée distante en production

L'environnement par défaut est l'environnement `dev`. Pour switcher d'environnment, il suffit de modifier la variable `spring.profiles.active` de `application.properties` en : `dev` , `local` ou `prod`

Exemple :

```
spring.profiles.active=dev
```

⚠️ Ne pas oublier de faire les migrations de bases de données nécessaires sur les différents environnements en cas de modifications des tables ou du script sql

NB : to update

### 🐳 Docker

- Lancer `docker`
- Vérifier l'environnement dans lequel vous voulez exécuter le server. Ou bien modifier le si besoin au niveau du service `enfiletesbaskets-server` dans le fichier `docker-compose.yml` avec les valeurs de `dev`, `local` ou `prod`
- Exécuter, à la racine du projet, la commande suivante

```
docker-compose up -d
```

- Normalement, cela va lancer une base de données postgres en local et un serveur spring qui va écouter en localhost au port `8081` => `http://localhost:8081/` dans l'environnement souhaité (par défaut `docker`)

## 🎨 Frontend

### 📱 Mobile

- Flutter

### 📊 Web Admin Dashboard

- React
- Tailwind CSS
- Recharts
- Framer Motion
