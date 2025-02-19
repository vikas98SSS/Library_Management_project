-- creating database
create database library_management;
-- creating multiple tables 
-- creating branch table
Drop table if exists branch;
Create table branch 
( branch_id varchar(20) primary key,
manager_id	varchar(15),
branch_address varchar(55),
contact_no varchar(12)
);

-- creating table employees
Drop table if exists employees;
create table employees
(emp_id	varchar(20) primary key,
emp_name varchar(25),
position varchar(25),	
salary int,	
branch_id varchar(20)
);

-- creating table books
Drop table if exists books;
create table books
(isbn varchar(20) primary key,	
book_title varchar(75),
category varchar(10),	
rental_price Float,	
status	varchar(15),
author	varchar(35),
publisher varchar(55)
);

-- creating table members
Drop table if exists members;
create table members
(member_id	varchar(20) primary key,
member_name	varchar(45),
member_address varchar(75),	
reg_date date
);

-- creating table issued_status
Drop table if exists issued_status;
create table issued_status 
(issued_id	varchar(20) primary key,
issued_member_id varchar(20),	
issued_book_name varchar(75),
issued_date	date,
issued_book_isbn varchar(20),	
issued_emp_id varchar(20)
);

-- creating table return_status
Drop table if exists return_status;
create table return_status
(return_id	varchar(20) primary key,
issued_id	varchar(20),
return_book_name varchar(75),	
return_date date,	
return_book_isbn  varchar(20)
);

-- Foreign keys 
Alter table employees
add constraint fk_branch_empl
foreign key(branch_id)
references branch(branch_id);

--
Alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

--
Alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

--
Alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);

--
Alter table return_status
add constraint fk_issued
foreign key (issued_id)
references issued_status(issued_id);

--
select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;
-- Project task
-- ### 2. CRUD Operations


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

-- Task 2: Update an Existing Member's Address


-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.


-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.


-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:


-- Task 8: Find Total Rental Income by Category:


-- Task 9. **List Members Who Registered in the Last 180 Days**:

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

-- Task 12: Retrieve the List of Books Not Yet Returned

    
/*
### Advanced SQL Operations

Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.


Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).



Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.


Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 6 months.



Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.


Task 18: Identify Members Issuing High-Risk Books
Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.    


Task 19: Stored Procedure
Objective: Create a stored procedure to manage the status of books in a library system.
    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
    If a book is issued, the status should change to 'no'.
    If a book is returned, the status should change to 'yes'.

Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines

--Below i have solved all querries of this project
*/
-- ### CRUD Operations
--Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

select * from books;

Insert into books (isbn,book_title,category,rental_price,status,author,publisher)
values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

--Task 2: Update an Existing Member's Address

select * from members;

update members
set member_address ='125 main st'
where member_id='C101';

--Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

Select * from issued_status;

Delete from issued_status
where issued_id='IS104'

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

select b.book_title from books b,issued_status I
where b.isbn=I.issued_book_isbn and I.issued_emp_id='E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

select m.member_name,count(I.issued_id) from members m,issued_status I
where m.member_id=I.issued_member_id
group by m.member_name
having count(I.issued_book_name)>1;

-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

Create table Book_cnts
AS
Select b.isbn,b.book_title,count(I.issued_id) as No_of_issued
from books b,issued_status I
where I.issued_book_isbn=b.isbn
group by b.isbn,b.book_title;

select * from Book_cnts;

-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:
select * from books
where category='History';

-- Task 8: Find Total Rental Income by Category:
select b.category,sum(b.rental_price*(select count(*) from issued_status)) as total_Income  from books b,issued_status I
where b.isbn=I.issued_book_isbn
group by b.category;

-- Task 9. **List Members Who Registered in the Last 180 Days**:
select * from members
where reg_date>=current_date- interval '180 Days';


-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:
select e1.*,b.manager_id,e2.emp_name as manager_name from employees as e1
join branch b
on e1.branch_id=b.branch_id
join employees e2
on b.manager_id=e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold $7 USD? 
create table new_table As(
select * from books
where rental_price>7
);
select * from new_table;

-- Task 12: Retrieve the List of Books Not Yet Returned

select distinct ist.issued_book_name from issued_status as ist
left join return_status as rt
on ist.issued_id=rt.issued_id
where rt.return_id is null;


--### Advanced SQL Operations

--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.
select ist.issued_member_id,
m.member_name,
b.book_title,
ist.issued_date,
current_date-ist.issued_date as over_dues_days
from issued_status as ist
join members as m
 on ist.issued_member_id=m.member_id
join books as b
 on b.isbn=ist.issued_book_isbn
left join return_status as rs
 on rs.issued_id=ist.issued_id
where rs.return_date is null and (current_date - ist.issued_date)>30
order by ist.issued_member_id;

/*Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to 
"Yes" when they are returned (based on entries in the return_status table).
*/
select * from issued_status
where issued_book_isbn='978-0-451-52994-2';

select * from books where isbn ='978-0-451-52994-2';

Update books 
set status='No'
where isbn='978-0-451-52994-2';

select * from return_status where return_book_isbn='978-0-451-52994-2'

-- 
insert into return_status (return_id,issued_id,return_date,return_book_name,return_book_isbn)
values ('RS125','IS130',current_date,'Moby Dick','978-0-451-52994-2');

--Store procedure 
Create or replace procedure add_return_records(p_return_id varchar(15),p_issued_id varchar(30),p_return_book_name varchar(100),p_return_book_isbn varchar(50))
language plpgsql
as $$
Declare 
begin
    insert into return_status (return_id,issued_id,return_date,return_book_name,return_book_isbn)
    values (p_return_id,p_issued_id,current_date,p_return_book_name,p_return_book_isbn);
	
	Update books 
    set status='Yes'
    where isbn=p_return_book_isbn;
	raise notice 'Thank you for returning the book ';
End;
$$
 -- testing functions 
select * from issued_status 
where issued_id='IS135';

select * from return_status
where issued_id='IS135';

select * from books where isbn='978-0-307-58837-1'

-- calling  function
call add_return_records('RS138','IS135','Sapiens: A Brief History of Humankind','978-0-307-58837-1')
delete from return_status where return_book_isbn='978-0-307-58837-1'
/*Task 15: Branch Performance Report
Create a query that generates a performance report for each branch,
showing the number of books issued, the number of books returned, 
and the total revenue generated from book rentals.
*/
select * from branch
select * from issued_status
select * from employees
select * from return_status
select * from books


Create table branch_report 
AS(
select 
b.branch_id,
b.manager_id,
count(ist.issued_id) as number_of_book_issued,
count(rs.return_id) as number_of_books_returned,
sum(bk.rental_price) as total_revenue
from issued_status as ist
join employees as e
on ist.issued_emp_id=e.emp_id
join branch as b
on b.branch_id=e.branch_id
left join return_status as rs
on rs.issued_id=ist.issued_id
join books as bk
on ist.issued_book_isbn=bk.isbn
group by b.branch_id,b.manager_id);

/*Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
containing members who have issued at least one book in the last 6 months.
*/
create table active_members as(
select * from members where member_id in
(
select distinct issued_member_id from issued_status
where issued_date>current_date - interval '6 month'))

select * from active_members


/*Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.
*/

select e.emp_name,
count(ist.issued_book_isbn) as number_of_books_processed,
b.branch_id
from issued_status as ist
join employees as e
on e.emp_id=ist.issued_emp_id
join branch as b
on b.branch_id=e.branch_id
join books as bk
on bk.isbn=ist.issued_book_isbn
group by 1,3
order by number_of_books_processed desc limit 3

/*Task 18: Identify Members Issuing High-Risk Books
Write a query to identify members who have issued books more than twice with 
the status "damaged" in the books table. Display the member name, book title, 
and the number of times they've issued damaged books. */

select m.member_name,b.book_title,
count(b.isbn) as number_of_damaged_book_issued 
from  members m,issued_status ist,books b
where ist.issued_book_isbn=b.isbn and ist.issued_member_id=m.member_id 
group by m.member_name,b.book_title
having count(ist.issued_book_isbn)>=2

/*Task 19: Stored Procedure
Objective: Create a stored procedure to manage the status of books in a library system.
    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
    If a book is issued, the status should change to 'no'.
    If a book is returned, the status should change to 'yes'.*/


CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(30), p_issued_book_isbn VARCHAR(30), p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
-- all the variabable
    v_status VARCHAR(10);

BEGIN
-- all the code
    -- checking if book is available 'yes'
    SELECT 
        status 
        INTO
        v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN

        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES
        (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

        UPDATE books
            SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        RAISE NOTICE 'Book records added successfully for book isbn : %', p_issued_book_isbn;


    ELSE
        RAISE NOTICE 'Sorry to inform you the book you have requested is unavailable book_isbn: %', p_issued_book_isbn;
    END IF;
END;
$$

-- Testing The function
SELECT * FROM books;
-- "978-0-553-29698-2" -- yes
-- "978-0-375-41398-8" -- no
SELECT * FROM issued_status;

CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');

SELECT * FROM books
WHERE isbn = '978-0-375-41398-8'



/*Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that 
lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines */


Create table overdue_days_fines
as
(
select ist.issued_member_id,
current_date-ist.issued_date as over_due_days,
(current_date-ist.issued_date )*0.5 as "Total_fine_in_$"
from issued_status as ist
join books as b
on ist.issued_book_isbn=b.isbn
join members as m
on ist.issued_member_id=m.member_id
left join return_status as rs
on ist.issued_id=rs.issued_id
where rs.return_date is null and (current_date-ist.issued_date)>30
order by ist.issued_member_id)

select * from overdue_days_fines

