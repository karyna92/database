CREATE TABLE STUDENTS (
    id serial PRIMARY KEY,
    first_name VARCHAR(70) NOT NULL CHECK (length(first_name) > 0), 
    last_name VARCHAR(70) NOT NULL CHECK (length(last_name) > 0),
    birthday DATE NOT NULL CHECK (birthday <= CURRENT_DATE), 
    gender VARCHAR(30) NOT NULL CHECK (length(gender) > 0)
);

CREATE TABLE COURSES (
    id serial PRIMARY KEY, 
    title VARCHAR(100) NOT NULL CHECK (length(title) > 0),
    description TEXT NOT NULL CHECK (length(description) > 0),
    hours INTEGER NOT NULL CHECK (hours > 0)
)

CREATE TABLE EXAMS (
    id serial PRIMARY KEY,
    id_student INTEGER NOT NULL REFERENCES STUDENTS(id),
    id_course INTEGER NOT NULL REFERENCES COURSES(id),
    mark INTEGER CHECK (mark >= 0 AND mark <= 100)
)


INSERT INTO STUDENTS (first_name, last_name, birthday, gender )
VALUES ('jan', 'trudoe', '1993-09-02', 'male'),
('petro', 'petrenko', '1992-09-03', 'male'),
('anna', 'doe', '1998-09-03', 'female'),
('mari', 'doe', '2000-07-04', 'female');

INSERT INTO COURSES (title, description, hours)
VALUES( 'Mathematics', 'Introduction to Mathematics', 40),
('Programming', 'Basics of Programming', 45),
('Chemistry', 'Basics of Chemistry', 50),
('Information Technologies', 'Basics of Tech', 30)

INSERT INTO EXAMS (id_student, id_course, mark)
VALUES (2, 1, 2),
(3, 2, 3),
(4, 3, NULL),
(1, 1, 5),
(2, 2, 4.5),
(3, 3, 1),
(4, 2, NULL),
(2, 4, 2),
(1, 4, 4)


-- *****************1

SELECT 
    s.first_name, 
    s.last_name, 
    c.title AS course_title
FROM 
    EXAMS e
JOIN 
    STUDENTS s ON e.id_student = s.id
JOIN 
    COURSES c ON e.id_course = c.id;

    --***************************2
    
    CREATE VIEW student_courses AS
SELECT 
    s.first_name, 
    s.last_name, 
    c.title AS course_title
FROM 
    EXAMS e
JOIN 
    STUDENTS s ON e.id_student = s.id
JOIN 
    COURSES c ON e.id_course = c.id;

--*********************************3
SELECT e.mark
FROM EXAMS e
JOIN STUDENTS s ON e.id_student = s.id
JOIN COURSES c ON e.id_course = c.id
WHERE s.first_name = 'petro'
  AND s.last_name = 'petrenko'
  AND c.title = 'Programming';

  --********************4

  SELECT   s.first_name || ' ' || s.last_name AS fullname
  FROM STUDENTS s 
  JOIN EXAMS e ON s.id=e.id_student
  WHERE e.mark < 3.5

  --********5
SELECT s.first_name
FROM EXAMS e
JOIN STUDENTS s ON e.id_student = s.id
JOIN COURSES c ON e.id_course = c.id
WHERE c.title = 'Programming'
  AND e.mark IS NOT NULL;

  --************************6


SELECT   COUNT(e.id_course) AS courses_attended,
  AVG(e.mark) AS average_mark
FROM EXAMS e
JOIN STUDENTS s ON e.id_student = s.id
JOIN COURSES c ON e.id_course = c.id


  --*********************7

    SELECT   s.first_name || ' ' || s.last_name AS fullname
  FROM STUDENTS s 
  JOIN EXAMS e ON s.id=e.id_student
   WHERE (
    SELECT AVG(mark) FROM EXAMS
) > 4.0;

-----*******9
SELECT s.first_name || ' ' || s.last_name AS fullname
FROM STUDENTS s
WHERE EXTRACT(MONTH FROM s.birthday) = EXTRACT(MONTH FROM 
(SELECT birthday FROM STUDENTS WHERE first_name = 'petro' AND last_name = 'petrenko'))
  AND EXTRACT(DAY FROM s.birthday) = EXTRACT(DAY FROM
   (SELECT birthday FROM STUDENTS WHERE first_name = 'petro' AND last_name = 'petrenko'));


----***************************10

SELECT 
  s.first_name, 
  e.id_student, 
  AVG(e.mark) AS average_mark
FROM EXAMS e
JOIN STUDENTS s ON e.id_student = s.id
GROUP BY e.id_student, s.first_name
HAVING AVG(e.mark) > (
  SELECT AVG(e2.mark)
  FROM EXAMS e2
  JOIN STUDENTS s2 ON e2.id_student = s2.id
  WHERE s2.first_name = 'petro' AND s2.last_name = 'petrenko'
);

---**************11

SELECT 
 c.title AS course_title
FROM COURSES c
WHERE c.hours> (
  SELECT c2.hours
  FROM COURSES c2
  WHERE c2.title= 'Information Technologies'
);

--**************12

SELECT 
  s.first_name,
  s.last_name,
  c.title AS course_title,
  e.mark
FROM EXAMS e
JOIN STUDENTS s ON e.id_student = s.id
JOIN COURSES c ON e.id_course = c.id
WHERE e.mark > (
  SELECT e2.mark
  FROM EXAMS e2
  JOIN STUDENTS s2 ON e2.id_student = s2.id
  WHERE s2.first_name = 'petro' AND s2.last_name = 'petrenko'
  ORDER BY e2.mark DESC
  LIMIT 1
);

----**************13
SELECT 
  s.first_name,
  s.last_name,
  c.title AS course_title,
  e.mark
FROM EXAMS e
JOIN STUDENTS s ON e.id_student = s.id
JOIN COURSES c ON e.id_course = c.id
-- WHERE e.mark >=5  ???






--*********8
SELECT c.title AS course
FROM COURSES c
LEFT JOIN EXAMS e ON c.id = e.id_course
WHERE e.id_course IS NULL;
