CREATE DATABASE library_chairman;
use library_chairman;
CREATE TABLE stg_libraries (
    library_code VARCHAR(10),
    library_name VARCHAR(100),
    district VARCHAR(50),
    mandal VARCHAR(50),
    established_year VARCHAR(10),
    total_books VARCHAR(20)
);
CREATE TABLE stg_employees (
    employee_code VARCHAR(15),
    employee_name VARCHAR(100),
    library_code VARCHAR(10),
    designation VARCHAR(50),
    salary VARCHAR(20),
    joining_date VARCHAR(20)
);

CREATE TABLE stg_readers (
    reader_code VARCHAR(20),
    reader_name VARCHAR(100),
    age VARCHAR(10),
    gender VARCHAR(20),
    library_code VARCHAR(10),
    membership_date VARCHAR(20),
    phone_number VARCHAR(20)
);
CREATE TABLE stg_books (
    isbn VARCHAR(20),
    title VARCHAR(200),
    author VARCHAR(100),
    genre VARCHAR(50),
    published_year VARCHAR(10),
    price VARCHAR(20),
    library_code VARCHAR(10)
);

drop table stg_books;
select * from stg_books;

CREATE TABLE stg_book_issues (
    issue_code VARCHAR(20),
    isbn VARCHAR(20),
    reader_code VARCHAR(20),
    issue_date VARCHAR(20),
    return_date VARCHAR(20),
    status VARCHAR(20),
    fine_amount VARCHAR(20)
);
drop table stg_book_issues;
CREATE TABLE stg_funds (
    library_code VARCHAR(10),
    fund_year VARCHAR(10),
    total_funds VARCHAR(20),
    spent VARCHAR(20),
    remaining VARCHAR(20)
);
select * from stg_book_issues;

