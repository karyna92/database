CREATE SCHEMA second;
CREATE TABLE second.students (
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(70) NOT NULL CHECK (length(first_name) > 0), 
    last_name VARCHAR(70) NOT NULL CHECK (length(last_name) > 0),
    birthday DATE NOT NULL CHECK (birthday <= CURRENT_DATE), 
    phone_number VARCHAR(15) NOT NULL CHECK (length(phone_number) > 0), 
    group_name VARCHAR(10) NOT NULL CHECK (group_name IN ('A1', 'B2', 'C3')), -- example groups
    avg_mark SMALLINT NOT NULL CHECK (avg_mark BETWEEN 0 AND 100), 
    gender VARCHAR(30) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other')), -- gender values
    entered_at SMALLINT NOT NULL CHECK (entered_at <= EXTRACT(YEAR FROM CURRENT_DATE)), 
    department VARCHAR(70) NOT NULL CHECK (department IN ('Computer Science', 'Mathematics', 'Physics')) -- departments
);

INSERT INTO second.students (first_name, last_name, birthday, phone_number, group_name, avg_mark, gender, entered_at, department)
VALUES 
('Olena', 'Shevchenko', '2002-04-15', '+380671112233', 'A1', 85, 'Female', 2020, 'Computer Science'),
('Anton', 'Antonov', '2001-09-30', '+380501234567', 'B2', 92, 'Male', 2019, 'Mathematics'),
('Sofiia', 'Bondar', '2003-01-10', '+380991112233', 'C3', 76, 'Female', 2021, 'Physics'),
('Dmytro', 'Melnyk', '2002-06-21', '+380933334455', 'A1', 88, 'Male', 2020, 'Computer Science'),
('Anastasiia', 'Tkachenko', '2000-12-05', '+380661234567', 'B2', 90, 'Female', 2018, 'Mathematics'),
('Andrii', 'Hnatyuk', '2001-11-18', '+380631112233', 'C3', 70, 'Male', 2019, 'Physics'),
('Mycola', 'Polishchuk', '2002-02-22', '+380731234567', 'A1', 95, 'Female', 2020, 'Computer Science'),
('Oleksii', 'Lysenko', '2003-03-11', '+380951234567', 'B2', 81, 'Male', 2021, 'Mathematics'),
('Maria', 'Voronina', '2000-07-14', '+380681122334', 'C3', 78, 'Female', 2018, 'Physics'),
('Yaroslav', 'Petrenko', '2001-05-09', '+380991234567', 'A1', 84, 'Other', 2019, 'Computer Science'),
('Viktoriia', 'Ivanenko', '2001-08-25', '+380671234000', 'B2', 87, 'Female', 2019, 'Mathematics'),
('Serhii', 'Dubovyk', '2002-05-17', '+380501234888', 'C3', 69, 'Male', 2020, 'Physics'),
('Yuliia', 'Zhuk', '2000-11-01', '+380931117722', 'A1', 91, 'Female', 2018, 'Computer Science'),
('Artem', 'Rudenko', '2003-04-12', '+380661234999', 'B2', 73, 'Male', 2021, 'Mathematics'),
('Iryna', 'Kravchenko', '2001-07-29', '+380991110011', 'C3', 80, 'Female', 2019, 'Physics'),
('Taras', 'Yatsenko', '2002-10-19', '+380671112244', 'A1', 85, 'Male', 2020, 'Computer Science'),
('Natalia', 'Moroz', '2000-09-13', '+380631234123', 'B2', 77, 'Female', 2018, 'Mathematics'),
('Roman', 'Bezruk', '2003-01-25', '+380951100000', 'C3', 82, 'Male', 2021, 'Physics'),
('Daria', 'Hlushko', '2002-03-04', '+380731111122', 'A1', 94, 'Female', 2020, 'Computer Science'),
('Maksym', 'Kostenko', '2001-06-06', '+380681234555', 'B2', 89, 'Male', 2019, 'Mathematics');


-------------------1
CREATE VIEW students_age AS SELECT 
  first_name || ' ' || last_name AS name, 
  EXTRACT(YEAR FROM birthday) AS birth_year
FROM second.students
ORDER BY birth_year ASC;

-------------------3

CREATE VIEW student_avg_marks AS
SELECT 
  first_name || ' ' || last_name AS name, 
  AVG(avg_mark) AS avg_student_mark
FROM second.students
GROUP BY name
ORDER BY avg_student_mark DESC;


-------------------4

SELECT *
FROM second.students
LIMIT 6
OFFSET 6;

------------------5

CREATE VIEW best_students AS
SELECT 
  first_name || ' ' || last_name AS name, 
  AVG(avg_mark) AS avg_student_mark
FROM second.students
GROUP BY name
ORDER BY avg_student_mark DESC
LIMIT 3;


------------------6

SELECT MAX(avg_mark) AS max_avg_mark
FROM second.students;

------------------7

SELECT 
  SUBSTRING(first_name, 1, 1) || '. ' || last_name AS name,
  '+380' || SUBSTRING(phone_number, 4, 2) || '*******' AS hidden_phone
FROM second.students;

------------------8

SELECT *
FROM second.students
WHERE first_name = 'Anton' AND last_name = 'Antonov';

------------------9

SELECT *
FROM second.students
WHERE birthday BETWEEN '2005-01-01' AND '2008-01-01';

-----------------10

SELECT *
FROM second.students
WHERE first_name = 'Mycola' AND avg_mark >= 45;

-----------------11

SELECT 
  group_name, 
  COUNT(*) AS students_amount
FROM second.students
GROUP BY group_name;

----------------12
SELECT 
 COUNT(*) AS students_amount
FROM second.students
WHERE entered_at=2018

----------------13

SELECT 
 first_name || ' ' || last_name AS name, phone_number
FROM second.students
WHERE phone_number LIKE '+38098';

----------------14

SELECT 
  department, 
   AVG(avg_mark) AS avg_avg_mark
FROM second.students
WHERE gender= 'female'
GROUP BY  department
ORDER BY avg_avg_mark DESC;

----------------15

SELECT 
  entered_at,
  MIN(avg_mark) AS min_avg_mark
FROM second.students
WHERE department = 'Computer Science' AND EXTRACT(MONTH FROM birthday) IN (6,7,8)
GROUP BY entered_at
HAVING MIN(avg_mark) > 3.5
ORDER BY entered_at;