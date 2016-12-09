CREATE DATABASE hair_salon;

\c hair_salon;

CREATE TABLE clients (id serial PRIMARY KEY, name varchar, specialty varchar, title varchar, image varchar, bio text);

CREATE TABLE stylists (id serial PRIMARY KEY, name varchar, next_appointment timestamp, stylist_id int);

CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
