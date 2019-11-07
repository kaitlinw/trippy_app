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
    lead_user_id INTEGER REFERENCES users(id),
    trip_name VARCHAR(100),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    trip_description VARCHAR(250)
);

INSERT INTO trip_data (user_id, trip_name, start_date, end_date, trip_description) VALUES (5, "European Getaway", "2020-04-11", "2020-05-15", "Girls getaway sipping Aperol Spritz on the beaches of Sorrento, Italy");



create table daily_trip_data (
    id_serial primary key,
    lead_user_id INTEGER REFERENCES users(id),
    trip_id INTEGER REFERENCES trip_data(id),
    date VARCHAR(50),
    location TEXT,
    travelling_to TEXT,
    activities TEXT,
    activities_time VARCHAR(50),
    transport TEXT,
    transport_time VARCHAR(50),
    accomodation TEXT,
    day_notes TEXT
);

INSERT INTO daily_trip_data (lead_user_id, trip_id, date, location, travelling_to, activities, activities_time, transport, transport_time, accomodation, day_notes) VALUES (5, 1, "2020-04-11", "Lisbon, Portugal", "Porto, Portugal", "Going to the beach", "10:00", "Train to Porto", "13:00", "Porto Hostel, Porto", "Checkout from Lisbon hostel at 11am.");



-- travel_buddy_1 TEXT,
--     travel_buddy_2 TEXT,
--     travel_buddy_3 TEXT,
-- "cate-g@gotmail.com"