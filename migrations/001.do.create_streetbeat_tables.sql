DROP TABLE IF EXISTS street_band_members;
DROP TABLE IF EXISTS street_setlist_songs;
DROP TABLE IF EXISTS street_users;
DROP TABLE IF EXISTS street_setlists;
DROP TABLE IF EXISTS street_songs;
DROP TABLE IF EXISTS street_bands;


CREATE TABLE street_users (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);

CREATE TABLE street_bands (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  band_name TEXT NOT NULL UNIQUE,
  city TEXT NOT NULL,
  state TEXT,
  country TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE street_band_members (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  user_id INTEGER REFERENCES street_users(id),
  band_id INTEGER REFERENCES street_bands(id)
);

CREATE TABLE street_songs (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  title TEXT NOT NULL,
  artist TEXT NOT NULL,
  duration TEXT NOT NULL,
  band_id INTEGER REFERENCES street_bands(id)
);

CREATE TABLE street_setlists (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  title TEXT NOT NULL, --gig or practice name, for instance
  date DATE
);

CREATE TABLE street_setlist_songs (
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  song_id INTEGER REFERENCES street_songs(id),
  song_position INTEGER NOT NULL,
  setlist_id INTEGER REFERENCES street_setlists(id),
  band_id INTEGER REFERENCES street_bands(id)
);

