--JOIN

create table teacher(
id serial primary key,
fullname varchar(50),
subject varchar(50))




create table student(
id serial primary key,
fullname varchar(50),
age int,
teacher_id int,
foreign key (teacher_id) references teacher(id)
)


INSERT INTO teacher (fullname, subject) VALUES
('Əli Məmmədov',   'Riyaziyyat'),
('Leyla Həsənova', 'Fizika'),
('Rauf Quliyev',   'Kimya'),
('Nigar Əliyeva',  'Tarix');

insert into teacher (fullname,subject) values('Mayis Qarayev','Informatika');

INSERT INTO student (fullname, age, teacher_id) VALUES
('Elvin Cəfərov',  15, 1),
('Aysel Babayeva', 16, 1),
('Murad İsmayılov', 15, 2),
('Səbinə Rzayeva', 17, 3),
('Tural Nəsirov',  16, 4),
('Günel Hüseynova', 15, NULL),
('Kamran Əhmədov', 17, NULL),
('Fidan Quliyeva', 16, NULL);


select *from teacher;
select *from student;

select * from student union all select * from teacher;

SELECT id, fullname, 'student' AS role FROM student
UNION ALL
SELECT id, fullname, 'teacher' AS role FROM teacher;

select s.fullname as studentname, t.fullname as teacherfull from student s inner join teacher t ON t.id=s.teacher_id;

select s.fullname as studentname,t.fullname as teachername from student s left join teacher t ON t.id=s.teacher_id;

select s.fullname as studentname, t.fullname as teachername from student s full join teacher t ON t.id=s.teacher_id;

select t.fullname as teachername,s.fullname as studentname from teacher t left join student s ON t.id=s.teacher_id where s.fullname is null;




--Self Join


create table employee(
id serial primary key,
name varchar(50),
position varchar(50),
manager_id int,
foreign key (manager_id) references employee(id)
)


INSERT INTO employee (name, position, manager_id) VALUES
('Rəşad Əliyev',     'CEO',                 NULL),  
('Nigar Hüseynova',  'CTO',                 1),     
('Elçin Məmmədov',   'HR Manager',          1),     
('Tural Quliyev',    'Senior Developer',    2),     
('Aysel Babayeva',   'Backend Developer',   2),     
('Səbinə Rzayeva',   'HR Specialist',       3),     
('Murad İsmayılov',  'Intern',              4),     
('Kamran Əhmədov',   'Freelance Consultant', NULL); 


SELECT e.name AS employee, m.name AS manager
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.id;


SELECT name FROM employee WHERE manager_id IS NULL;




create table students(
id serial primary key,
name varchar(50)
)

create table courses(
id serial primary key,
course_title varchar(50)
)


create table student_courses(
    fk_students_id int,
    fk_courses_id int,
    primary key (fk_students_id, fk_courses_id),
    foreign key (fk_students_id) references students(id),
    foreign key (fk_courses_id) references courses(id)
);




insert into students (name) values
('Elvin Cəfərov'),    -- id 1
('Aysel Babayeva'),   -- id 2
('Murad İsmayılov'),  -- id 3
('Səbinə Rzayeva'),   -- id 4
('Tural Nəsirov'),    -- id 5
('Günel Hüseynova');  -- id 6

insert into courses (course_title) values
('SQL'),         -- id 1
('Python'),      -- id 2
('Java'),        -- id 3
('Networking');  -- id 4

insert into student_courses (fk_students_id, fk_courses_id) values
(1, 1),  -- Elvin   - SQL
(1, 2),  -- Elvin   - Python
(2, 1),  -- Aysel   - SQL
(3, 3),  -- Murad   - Java
(4, 2),  -- Səbinə  - Python
(4, 4),  -- Səbinə  - Networking
(5, 1),  -- Tural   - SQL
(6, 3);  -- Günel   - Java






--cascade set null

create table customer(
id serial primary key,
name varchar(50)
)

create table orderss (
id serial primary key,
product varchar(50),
customer_id int,
foreign key (customer_id) references customer(id)
)

insert into customer (name) values
('Elvin Cəfərov'),    -- id 1
('Aysel Babayeva'),   -- id 2
('Murad İsmayılov'),  -- id 3
('Səbinə Rzayeva'),   -- id 4
('Tural Nəsirov');    -- id 5

insert into orderss (product, customer_id) values
('Noutbuk',       1),
('Siçan',         1),
('Telefon',       2),
('Qulaqlıq',      2),
('Klaviatura',    2),
('Monitor',       3),
('Planşet',       4),
('Printer',       NULL);

select * from customer;
select * from orderss;


delete  from customer where id=1;


alter table orderss
drop constraint orderss_customer_id_fkey;

alter table orderss
add constraint orderss_customer_id_fkey
foreign key (customer_id) references customer(id)
on delete set null;

select *from customer;
select* from orderss;

alter table orderss
drop constraint orderss_customer_id_fkey;

alter table orderss
add constraint orderss_customer_id_fkey
foreign key (customer_id) references customer(id)
on delete cascade;




delete from customer where id = 2;


select conname
from pg_constraint
where conrelid = 'orderss'::regclass and contype = 'f';




create table aran(
    id serial ,
    customer_id int,
    constraint pk_aran primary key(id)     

);
select conname
from pg_constraint
where conrelid = 'aran'::regclass and contype = 'p';


--Group by Having


create table employees(
id serial primary key,
first_name varchar(50),
last_name varchar(50),
department varchar(50),
position varchar(50),
salary int,
hire_date date,
city varchar(20)
)

INSERT INTO employees
(first_name, last_name, department, position, salary, hire_date, city)
VALUES
('Ali', 'Mammadov', 'IT', 'Developer', 2500, '2021-03-15', 'Baku'),
('Veli', 'Aliyev', 'IT', 'Developer', 2200, '2022-06-10', 'Baku'),
('Aysel', 'Hasanova', 'HR', 'HR Manager', 1800, '2020-01-20', 'Ganja'),
('Nicat', 'Karimov', 'IT', 'System Administrator', 2000, '2023-04-12', 'Baku'),
('Leyla', 'Huseynova', 'Finance', 'Accountant', 1600, '2021-09-05', 'Sumqayit'),
('Samir', 'Ismayilov', 'Finance', 'Financial Analyst', 2100, '2019-11-18', 'Baku'),
('Murad', 'Rahimov', 'HR', 'Recruiter', 1400, '2022-02-14', 'Ganja'),
('Nigar', 'Abbasova', 'IT', 'Developer', 2700, '2020-07-25', 'Sumqayit'),
('Elvin', 'Jafarov', 'Sales', 'Sales Manager', 1900, '2024-01-08', 'Baku'),
('Gunel', 'Aliyeva', 'Sales', 'Sales Representative', 1500, '2023-08-19', 'Shaki');


SELECT COUNT(id)
FROM employees;

select AVG(salary) from employees;

SELECT MAX(salary) AS max_salary,MIN(salary) AS min_salary FROM employees;

Select Sum(salary) as total from employees;

SELECT department, COUNT(*) FROM employees GROUP BY department;
SELECT department, AVG(salary) FROM employees GROUP BY department;
SElect  city,AVG(salary),Count(*) from employees group by city;


SELECT department, COUNT(*) FROM employees GROUP BY department;
SELECT position, COUNT(*) FROM employees GROUP BY position;



SELECT department, COUNT(*) FROM employees GROUP BY department HAVING COUNT(*) > 2; 

select department,AVG(salary) from employees group by department HAVING AVG(salary) > 3000; 

select department,AVG(salary) from employees group by department having avg(salary)>2000;


select department,city,COunt(*) from employees group by department having avg(salary)>2000;



SELECT first_name, last_name, department
FROM employees
WHERE city = 'Baku'
AND department IN (
    SELECT department
    FROM employees
    WHERE city = 'Baku'
    GROUP BY department
    HAVING COUNT(*) > 2
);






--Subquery

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

/*
SELECT column_name
FROM table_name
WHERE column_name operator (
    SELECT column_name
    FROM table_name
    WHERE condition
);

Daxili sorğu həmişə SELECT ilə başlayır, amma Subquery yalnız WHERE daxilində istifadə olunmur.
*/



SELECT *
FROM (
    SELECT AVG(salary) AS average_salary
    FROM employees
) AS result;

--CTE SQL-də müvəqqəti nəticə yaratmaq və həmin nəticədən əsas sorğuda istifadə etmək üçündür.


WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 2000
)
SELECT *
FROM high_salary;





/*VIEW uzun və tez-tez istifadə olunan SQL sorğularını yadda saxlayaraq,
onları sonradan sadə cədvəl kimi çağırmaq üçün istifadə olunur.*/
CREATE VIEW high_salary_employees AS
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 2000;


SELECT * FROM high_salary_employees;







--Transaction – bir neçə SQL əməliyyatını vahid əməliyyat kimi idarə edir.

BEGIN;

UPDATE employees
SET salary = 3000
WHERE id = 1;

COMMIT;

--Function – müəyyən əməliyyatı yerinə yetirən və nəticə qaytara bilən istifadəçi funksiyasıdır.
CREATE FUNCTION annual_salary(monthly_salary INT)
RETURNS INT
LANGUAGE SQL
AS $$
    SELECT monthly_salary * 12;
$$;

SELECT annual_salary(2000);




--Trigger – müəyyən hadisə baş verdikdə avtomatik işləyən mexanizmdir.
CREATE TABLE employee_logs (
    id SERIAL PRIMARY KEY,
    employee_name VARCHAR(50),
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE FUNCTION log_employee()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employee_logs (employee_name)
    VALUES (NEW.first_name);

    RETURN NEW;
END;
$$;

CREATE TRIGGER employee_insert_trigger
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee();


INSERT INTO employees
(first_name, last_name, department, salary, city)
VALUES
('Rashad', 'Aliyev', 'IT', 2500, 'Baku');


select *from employee_logs;

