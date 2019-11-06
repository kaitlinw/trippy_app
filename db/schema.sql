CREATE DATABASE trippy_app;

create table users (
    id serial primary key,
    first_name VARCHAR(30),
    last_name VARCHAR(50),
    email VARCHAR(50),
    password_digest TEXT
);

create table trip_data (
    id serial primary key,
    user_id INTEGER REFERENCES users(id),
    trip_name VARCHAR(100),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    trip_description VARCHAR(250),
    travel_buddy_1 TEXT,
    travel_buddy_2 TEXT,
    travel_buddy_3 TEXT,

)


INSERT INTO trip_data (user_id, trip_name, start_date, end_date, trip_description, travel_buddy_1) VALUES (5, "European Getaway", "2020-04-11", "2020-05-15", "Girls getaway sipping Aperol Spritz on the beaches of Sorrento, Italy", "cate-g@gotmail.com");