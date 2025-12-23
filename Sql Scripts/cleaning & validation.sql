use library_chairman;

SELECT * FROM stg_libraries
WHERE library_code IS NULL OR library_code = '';

SELECT * FROM stg_employees
WHERE employee_code IS NULL OR employee_code = '';

SELECT * FROM stg_books
WHERE isbn IS NULL OR isbn = '';

SELECT * FROM stg_book_issues
WHERE issue_code  IS NULL OR issue_code = '';

SELECT * FROM stg_readers
WHERE reader_code IS NULL OR reader_code = '';

SELECT * FROM stg_funds
WHERE fund_year IS NULL OR fund_year = '';

SELECT library_code, COUNT(*)
FROM stg_libraries
GROUP BY library_code
HAVING COUNT(*) > 1;

SELECT emplyoee_code, COUNT(*)
FROM stg_employees
GROUP BY employee_code
HAVING COUNT(*) > 1;

SELECT reader_code, COUNT(*)
FROM stg_readers
GROUP BY reader_code
HAVING COUNT(*) > 1;

SELECT isbn, COUNT(*)
FROM stg_books
GROUP BY isbn
HAVING COUNT(*) > 1;

SELECT issue_code, COUNT(*)
FROM stg_book_issues
GROUP BY issue_code
HAVING COUNT(*) > 1;

CREATE TABLE stg_books_clean AS
SELECT DISTINCT
    isbn,
    title,
    author,
    genre,
    published_year,
    price,
    library_code
FROM stg_books;

DROP TABLE stg_books;
RENAME TABLE stg_books_clean TO stg_books;

SELECT *
FROM stg_libraries
WHERE total_books NOT REGEXP '^[0-9]+$';

SELECT *
FROM stg_employees
WHERE salary NOT REGEXP '^[0-9]+(\\.[0-9]{1,2})?$';

SELECT *
FROM stg_books
WHERE price NOT REGEXP '^[0-9]+(\\.[0-9]{1,2})?$';

SELECT *
FROM stg_readers
WHERE membership_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
AND membership_date IS NOT NULL;

SELECT *
FROM stg_books
WHERE published_year NOT REGEXP '^[0-9]{4}$';

SET SQL_SAFE_UPDATES = 0;

UPDATE stg_book_issues
SET return_date = DATE_FORMAT(
    STR_TO_DATE(return_date, '%m/%d/%Y'),
    '%Y-%m-%d'
)
WHERE return_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';


SET SQL_SAFE_UPDATES = 1;

SELECT DISTINCT designation
FROM stg_employees
WHERE designation NOT IN ('Librarian','Assistant','Clerk','Manager');

SELECT DISTINCT gender
FROM stg_readers
WHERE gender NOT IN ('Male','Female','Other');

SELECT DISTINCT status
FROM stg_book_issues
WHERE status NOT IN ('Issued','Returned','Overdue');

SELECT DISTINCT library_code
FROM stg_employees
WHERE library_code NOT IN (
    SELECT library_code FROM stg_book_issues
);

SELECT *
FROM stg_book_issues
WHERE isbn NOT IN (SELECT isbn FROM stg_books)
   OR reader_code NOT IN (SELECT reader_code FROM stg_readers);

CREATE TABLE stg_book_issues_reject AS
SELECT *
FROM stg_book_issues
WHERE isbn NOT IN (SELECT isbn FROM stg_books)
   OR reader_code NOT IN (SELECT reader_code FROM stg_readers);
   
DELETE FROM stg_book_issues
WHERE isbn NOT IN (SELECT isbn FROM stg_books)
   OR reader_code NOT IN (SELECT reader_code FROM stg_readers);
   
   UPDATE stg_book_issues
SET issue_date = STR_TO_DATE(issue_date, '%m/%d/%Y')
WHERE issue_date LIKE '%/%/%';

UPDATE stg_book_issues
SET return_date = STR_TO_DATE(return_date, '%m/%d/%Y')
WHERE return_date LIKE '%/%/%';
SELECT issue_code, issue_date, return_date
FROM stg_book_issues
LIMIT 10;




   

   
































