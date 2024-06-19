-- Active: 1718800185592@@bartuhyeqkcf55owco3z-postgresql.services.clever-cloud.com@50013

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    full_name VARCHAR(100),
    phone_number VARCHAR(15),
    role VARCHAR(20) NOT NULL
);

SELECT * FROM users 

DROP TABLE users;

CREATE TABLE Rooms (
    room_id SERIAL PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL,
    rows INTEGER NOT NULL,
    columns INTEGER NOT NULL,
    location VARCHAR(200),
    has_projector BOOLEAN,
    has_whiteboard BOOLEAN
);

SELECT * FROM Rooms 

CREATE TABLE Workspaces (
    workspace_id SERIAL PRIMARY KEY,
    room_id INTEGER,
    row_number INTEGER NOT NULL,
    column_number INTEGER NOT NULL,
    workspace_type VARCHAR(50),
    has_power_outlet BOOLEAN,
    UNIQUE (room_id, row_number, column_number)
);

DROP TABLE Workspaces

SELECT * FROM Workspaces 

CREATE TABLE Sessions (
    session_id SERIAL PRIMARY KEY,
    session_name VARCHAR(100) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    max_capacity INTEGER
);

SELECT * FROM Sessions 

CREATE TABLE Reservations (
    reservation_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    workspace_id INTEGER,
    session_id INTEGER,
    reservation_time TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL,
    comments TEXT
);

DROP TABLE Reservations

SELECT * FROM Reservations 

ALTER TABLE Workspaces ADD FOREIGN KEY (room_id) REFERENCES Rooms (room_id) 

ALTER TABLE Reservations ADD FOREIGN KEY (user_id) REFERENCES Users (user_id) 

ALTER TABLE Reservations ADD FOREIGN KEY (workspace_id) REFERENCES Workspaces (workspace_id) 

ALTER TABLE Reservations ADD FOREIGN KEY (session_id) REFERENCES Sessions (session_id) 