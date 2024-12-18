-- Création des tables principales
CREATE TABLE Tag (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    xPos FLOAT,
    yPos FLOAT
);

CREATE TABLE "User" (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    pseudo VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    firstName VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    profilPicture BYTEA,
    role VARCHAR(50),
    nbPostDeleted INT DEFAULT 0,
    banDate DATE
);

CREATE TABLE Post (
    id SERIAL PRIMARY KEY,
    description TEXT,
    datePost DATE NOT NULL,
    image bytea,
    related INT REFERENCES Post(id),
    nbLike INT DEFAULT 0,
    nbPost INT DEFAULT 0,
    visible BOOLEAN DEFAULT TRUE,
    creator INT REFERENCES "User"(id),
    banDate DATE
);

CREATE TABLE Category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Community (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    admin INT REFERENCES "User"(id),
    category INT REFERENCES Category(id),
    banDate DATE,
    public BOOLEAN DEFAULT TRUE
);

CREATE TABLE Class (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    owner INT REFERENCES "User"(id),
    password VARCHAR(255),
    time INT,
    begin_date DATE,
    end_date DATE
);

CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    "user" INT REFERENCES "User"(id),
    begin_date DATE,
    end_date DATE
);

CREATE TABLE Actuality (
    id SERIAL PRIMARY KEY,
    creator INT REFERENCES "User"(id),
    title VARCHAR(255),
    description TEXT,
    image bytea
);

CREATE TABLE User_Tags (
    user_id INT REFERENCES "User"(id) ON DELETE CASCADE,
    tag_id INT REFERENCES Tag(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, tag_id)
);

CREATE TABLE User_Courses (
    user_id INT REFERENCES "User"(id) ON DELETE CASCADE,
    course_id INT REFERENCES Course(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, course_id)
);

CREATE TABLE Class_Tags (
    class_id INT REFERENCES Class(id) ON DELETE CASCADE,
    tag_id INT REFERENCES Tag(id) ON DELETE CASCADE,
    PRIMARY KEY (class_id, tag_id)
);

CREATE TABLE Class_Courses (
    class_id INT REFERENCES Class(id) ON DELETE CASCADE,
    course_id INT REFERENCES Course(id) ON DELETE CASCADE,
    PRIMARY KEY (class_id, course_id)
);

CREATE TABLE Community_Users (
    community_id INT REFERENCES Community(id) ON DELETE CASCADE,
    user_id INT REFERENCES "User"(id) ON DELETE CASCADE,
    PRIMARY KEY (community_id, user_id)
);

CREATE TABLE Community_Posts (
    community_id INT REFERENCES Community(id) ON DELETE CASCADE,
    post_id INT REFERENCES Post(id) ON DELETE CASCADE,
    PRIMARY KEY (community_id, post_id)
);

CREATE TABLE Community_BannedUsers (
    community_id INT REFERENCES Community(id) ON DELETE CASCADE,
    user_id INT REFERENCES "User"(id) ON DELETE CASCADE,
    PRIMARY KEY (community_id, user_id)
);

CREATE TABLE Community_Moderators (
    community_id INT REFERENCES Community(id) ON DELETE CASCADE,
    user_id INT REFERENCES "User"(id) ON DELETE CASCADE,
    PRIMARY KEY (community_id, user_id)
);
