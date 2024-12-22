-- project -> student management system

create database student_management_system;

use student_management_system;

create table students (
student_id int primary key auto_increment,
first_name varchar(50),
last_name varchar(50),
email varchar(100),
gender varchar(20)
);

create table instructors (
instructor_id int primary key auto_increment,
instructor_name varchar(50)
);

create table courses (
course_id int primary key auto_increment,
course_name varchar(50),
instructor_id int,
foreign key (instructor_id) references instructors (instructor_id)
);

create table enrollments (
enrollment_id int primary key auto_increment,
student_id int,
course_id int,
enrollment_date date,
foreign key (student_id) references students(student_id),
foreign key (course_id) references courses(course_id)
);

create table grades (
grade_id int primary key auto_increment,
enrollment_id int,
grade char(2),
foreign key (enrollment_id) references enrollments(enrollment_id)
);

insert into students (first_name, last_name,email,gender) values
('Sandhiya','Arasu','sandhiyaarasu2004@gmail.com','F'),
('Janani','Rajesh','jananirajesh@gmail.com','F'),
('James','Smith','jamessmith@gmail.com','M'),
('Ajay','Kumar','ajaykumar@gmail.com','M'),
('Pradeep','Kumar','pradeepkumar@gmail.com','M'),
('Arjun','Das','arjundas@gmail.com','M'),
('Bala','Subramanian','balasubramaniam@gmail.com','M'),
('Pranav','Venkatesh','pranavvenkatesh@gmail.com','M'),
('Meenakshi','Ramesh','meenakshiramesh@gmail.com','F'),
('Harini','prakash','hariniprakash@gmail.com','F'),
('Diya','Rajesh','diyarajesh@gmail.com','F'),
('Nandini','Krishnan','nandinikrishnan@gmail.com','F'),
('Harish','Gowtham','harishgowtham@gmail.com','M'),
('Dhruv','Vikram','dhruvvikram@gmail.com','M'),
('Kavin','Selvam','kavinselvam@gmail.com','M');

insert into instructors (instructor_name) values
('Babu'),
('Imran'),
('Sabari'),
('Sanjay'),
('Kaviya'),
('Abinaya'),
('Yazhini'),
('Meera'),
('Atharva'),
('Vikram');

insert into courses (course_name,instructor_id) values
('Sql',1),
('Frontend',2),
('Java',3),
('Data Science',4),
('Cyber Security',5),
('AI & Machine Learning',6),
('Cloud Computing',7),
('DevOps', 8),
('UI/UX Design',9),
('Full stack',10);

insert into enrollments (student_id, course_id,enrollment_date) values
(1,1,'2024-11-04'),
(2,2,'2024-12-03'),
(3,5,'2024-12-14'),
(4,3,'2024-10-10'),
(5,7,'2024-05-03'),
(6,9,'2024-01-02'),
(7,4,'2024-07-12'),
(8,7,'2024-08-21'),
(9,1,'2024-05-15'),
(10,1,'2024-06-17'),
(11,2,'2024-07-25'),
(12,5,'2024-10-15'),
(13,6,'2024-12-12'),
(14,6,'2024-12-10'),
(15,3,'2024-04-01');

insert into grades (enrollment_id, grade) values
(1,'A'),
(2,'A'),
(3,'B'),
(4,'C'),
(5,'C'),
(6,'A'),
(7,'B'),
(8,'C'),
(9,'B'),
(10,'A'),
(11,'B'),
(12,'A'),
(13,'C'),
(14,'A'),
(15,'A');

select case 
when gender = 'M' then 'Male'
else 'Female'
end as gender
from students;

select * from students;
select * from instructors;
select * from courses;
select * from enrollments;
select * from grades;

-- fetch the student names along with course name they are enrolled in
select s.first_name, s.last_name , c.course_name
from enrollments as e
join students as s on s.student_id = e.student_id
join courses as c on c.course_id = e.course_id;

-- fetch the course names along with the instructor name for each course
select c.course_name as c, i.instructor_name as i
from courses as c
join instructors as i on i.instructor_id = c.instructor_id;

-- fetch the students name, course name, instructor name and grades for all enrollments
select s.first_name , s.last_name , c.course_name , i.instructor_name, g.grade 
from enrollments as e
join students as s on s.student_id = e.student_id
join courses as c on c.course_id = e.course_id
join instructors as i on i.instructor_id = c.instructor_id
join grades as g on e.enrollment_id =  g.enrollment_id;

-- Fetch the names of students who have received an 'A' grade in at least one course.
select s.first_name , s.last_name from students as s
where s.student_id in 
(select e.student_id from enrollments as e
join grades as g on e.enrollment_id = g.enrollment_id
where g.grade = "A");

-- Create a stored procedure that retrieves all the students who are enrolled in a course taught by a specific instructor.
delimiter $$
create procedure getcourse()
begin
select s.first_name, s.last_name, c.course_name, i.instructor_name
from students as s
join enrollments as e on e.student_id = s.student_id
join courses as c on c.course_id = e.course_id
join instructors as i on i.instructor_id = c.instructor_id  ;
end $$
delimiter ;
call getcourse();


-- number of students enrolled in each course
delimiter $$
create procedure student_in_each_course()
begin
select count(s.student_id) as no_of_students , c.course_name
from students as s
join enrollments as e on e.student_id = s.student_id
join courses as c on c.course_id = e.course_id 
group by c.course_name;
end $$
delimiter ;

call student_in_each_course();
drop procedure if exists student_in_each_course;

-- altering
alter table students add column ph_no int;
alter table students modify column email varchar(100);
alter table students drop column ph_no;

-- updating
update grades set grade =  "A" where enrollment_id = 1;
update courses set instructor_id = 2 where course_id = 1;
update students set email = "newemail@gmail.com" where student_id= 3;