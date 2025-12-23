use library_chairman;
CREATE TABLE libraries (
    library_id INT PRIMARY KEY AUTO_INCREMENT,
    library_code VARCHAR(10) UNIQUE NOT NULL,
    library_name VARCHAR(100) NOT NULL,
    district VARCHAR(50),
    mandal VARCHAR(50),
    established_year YEAR,
    total_books INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_code VARCHAR(15) UNIQUE NOT NULL,
    employee_name VARCHAR(100),
    library_id INT,
    designation ENUM('Librarian','Assistant','Clerk','Manager'),
    salary DECIMAL(10,2),
    joining_date DATE,
    FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);
CREATE TABLE readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    reader_code VARCHAR(20) UNIQUE,
    reader_name VARCHAR(100),
    age TINYINT,
    gender ENUM('Male','Female','Other'),
    library_id INT,
    membership_date DATE,
    phone_number BIGINT,
    FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);
drop table readers;
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(200),
    author VARCHAR(100),
    genre ENUM('Science','Literature','History','Technology','Arts'),
    published_year YEAR,
    price DECIMAL(8,2),
    library_id INT,
    library_code varchar(200),
    FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE books;
CREATE TABLE book_issues (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    issue_code VARCHAR(20),
    book_id INT,
    reader_id INT,
    issue_date DATE,
    return_date DATE,
    status ENUM('Issued','Returned','Overdue'),
    fine_amount DECIMAL(6,2),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (reader_id) REFERENCES readers(reader_id)
);
CREATE TABLE funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    library_id INT,
    fund_year YEAR,
    total_funds DECIMAL(12,2),
    spent DECIMAL(12,2),
    remaining DECIMAL(12,2),
    FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);