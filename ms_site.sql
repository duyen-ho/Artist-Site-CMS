CREATE DATABASE miasalsjo;

CREATE TABLE works (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(200),
  work_type_id INTEGER,
  medium VARCHAR(300),
  dimensions VARCHAR(100),
  image_url TEXT,
  video_url TEXT,
  display_homepage BOOLEAN,
  notes TEXT
);

CREATE TABLE works_type (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300),
  password_digest VARCHAR(400)
);

-- no associations
CREATE TABLE biography (
  intro TEXT,
  education TEXT,
  solo_exhibitions TEXT,
  group_exhibitions TEXT,
  performances TEXT,
  awards TEXT,
  publications TEXT,
  interviews TEXT
);

-- no associations
CREATE TABLE contacts (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR (250),
  email VARCHAR(300)
);
