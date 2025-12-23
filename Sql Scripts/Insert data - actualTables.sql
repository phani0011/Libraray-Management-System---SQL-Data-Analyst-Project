INSERT INTO libraries (
    library_code,
    library_name,
    district,
    mandal,
    established_year,
    total_books
)
SELECT
    library_code,
    library_name,
    district,
    mandal,
    CAST(established_year AS UNSIGNED),
    CAST(total_books AS UNSIGNED)
FROM stg_libraries;

INSERT INTO employees (
    employee_code, employee_name, library_id,
    designation, salary, joining_date
)
SELECT
    e.employee_code,
    e.employee_name,
    l.library_id,
    e.designation,
    CAST(e.salary AS DECIMAL(10,2)),
    STR_TO_DATE(e.joining_date,'%Y-%m-%d')
FROM stg_employees e
JOIN libraries l
ON e.library_code = l.library_code;

INSERT INTO readers (
    reader_code, reader_name, age, gender,
    library_id, membership_date, phone_number
)
SELECT
    r.reader_code,
    r.reader_name,
    CAST(r.age AS UNSIGNED),
    r.gender,
    l.library_id,
    STR_TO_DATE(r.membership_date,'%Y-%m-%d'),
    CAST(r.phone_number AS UNSIGNED)
FROM stg_readers r
JOIN libraries l
ON r.library_code = l.library_code;

INSERT INTO books (
    isbn,
    title,
    author,
    genre,
    published_year,
    price,
    library_id
)
SELECT
    b.isbn,
    b.title,
    b.author,
    b.genre,
    CAST(b.published_year AS UNSIGNED),
    CAST(NULLIF(b.price, '') AS DECIMAL(8,2)),
    l.library_id
FROM stg_books b
JOIN libraries l
    ON b.library_code = l.library_code;

select * from books;


INSERT INTO book_issues (
    issue_code,
    book_id,
    reader_id,
    issue_date,
    return_date,
    status,
    fine_amount
)
SELECT
    i.issue_code,
    bk.book_id,
    r.reader_id,
    i.issue_date,
    CASE WHEN i.return_date = '' THEN NULL ELSE i.return_date END,
    i.status,
    CAST(NULLIF(i.fine_amount,'') AS DECIMAL(6,2))
FROM stg_book_issues i
JOIN books bk ON i.isbn = bk.isbn
JOIN readers r ON i.reader_code = r.reader_code;

select * from book_issues;


INSERT INTO funds (
    library_id, fund_year, total_funds, spent, remaining
)
SELECT
    l.library_id,
    SUBSTRING(f.fund_year,1,4),
    CAST(NULLIF(f.total_funds,'') AS DECIMAL(12,2)),
    CAST(NULLIF(f.spent,'') AS DECIMAL(12,2)),
    CAST(NULLIF(f.remaining,'') AS DECIMAL(12,2))
FROM stg_funds f
JOIN libraries l
ON f.library_code = l.library_code;

select * from funds;











