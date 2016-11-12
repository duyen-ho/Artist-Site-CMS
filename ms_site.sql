CREATE DATABASE miasalsjo;

CREATE TABLE works (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(200),
  work_type_id INTEGER,
  medium VARCHAR(300),
  dimensions VARCHAR(100),
  image_url TEXT,
  video_url TEXT,
  display_homepage BOOLEAN DEFAULT 'false',
  notes TEXT
);

CREATE TABLE work_types (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100),
  username VARCHAR(100),
  email VARCHAR(300),
  password_digest VARCHAR(400)
);

-- no associations
CREATE TABLE biographies (
  id SERIAL4 PRIMARY KEY,
  body TEXT
);

-- no associations
CREATE TABLE contacts (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR (250),
  email VARCHAR(300)
);
