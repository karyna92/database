CREATE TABLE STUDENTS (
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(70) NOT NULL CHECK (length(first_name) > 0), 
    last_name VARCHAR(70) NOT NULL CHECK (length(last_name) > 0),
    birthday DATE NOT NULL CHECK (birthday <= CURRENT_DATE), 
    phone_number VARCHAR(15) NOT NULL CHECK (length(phone_number) > 0), 
    group_name VARCHAR(10) NOT NULL CHECK (length(group_name) > 0),
    avg_mark SMALLINT NOT NULL CHECK (avg_mark BETWEEN 0 AND 100), 
    gender VARCHAR(30) NOT NULL CHECK (length(gender) > 0), 
    entered_at SMALLINT NOT NULL CHECK (entered_at <= EXTRACT(YEAR FROM CURRENT_DATE)), 
    department VARCHAR(70) NOT NULL CHECK (length(department) > 0)
);

-- DROP TABLE STUDENTS

INSERT INTO STUDENTS (first_name, last_name, birthday, phone_number, group_name, avg_mark, gender, entered_at, department)
VALUES ('jan', 'trudoe', '1994-09-03', '+380665770179', '5b', 59, 'male', 2009, 'medecine'),
 ('dan', 'frode', '1992-09-03', '+380665570179', '2a', 98, 'male', 2007, 'math'),
  ('anna', 'doe', '1998-09-03', '+380661170179', '1b', 88, 'male', 2017, 'biology');
