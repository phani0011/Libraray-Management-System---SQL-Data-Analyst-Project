select library_name,library_code,district from libraries
where established_year < 2000
AND total_books > 5000;

select 
l.library_code,
l.library_name,
count(e.employee_id) as total_employees
from libraries l
LEFT JOIN employees e
on l.library_id = e.library_id
group by
l.library_id,
l.library_name,
l.library_code
order by total_employees desc;


select
l.library_name,
l.library_code,
count(r.reader_id) as total_readers
from libraries l
left join readers r
on l.library_id = r.library_id
group by
l.library_id,
l.library_code,
l.library_name
order by total_readers desc;

SELECT
    genre,
    COUNT(book_id) AS total_books
FROM books
GROUP BY genre
ORDER BY total_books DESC;
select * from  stg_books;


SELECT 
    l.library_id,
    l.library_name,
    COUNT(b.book_id) AS total_books
FROM libraries l
JOIN books b
    ON l.library_id = b.library_id
GROUP BY l.library_id, l.library_name
ORDER BY total_books DESC
LIMIT 3;

select status, count(book_id) as total_values
from book_issues
group by status;
select * from book_issues;


SELECT 
    b.title AS book_title,
    r.reader_name,
    l.library_name,
    bi.issue_date,
    bi.return_date,
    bi.fine_amount
FROM book_issues bi
JOIN books b 
    ON bi.book_id = b.book_id
JOIN readers r 
    ON bi.reader_id = r.reader_id
JOIN libraries l 
    ON b.library_id = l.library_id
WHERE bi.status = 'Overdue';


SELECT 
    r.reader_name,
    r.reader_code,
    l.library_name,
    COUNT(bi.issue_id) AS books_issued_count
FROM book_issues bi
JOIN readers r 
    ON bi.reader_id = r.reader_id
JOIN libraries l 
    ON r.library_id = l.library_id
WHERE bi.status IN ('Issued', 'Overdue')
GROUP BY r.reader_id, r.reader_name, r.reader_code, l.library_name
HAVING COUNT(bi.issue_id) = 2;


SELECT 
    b.title AS book_title,
    b.isbn
	FROM books b
		LEFT JOIN book_issues bi
    ON b.book_id = bi.book_id
	WHERE bi.issue_id IS NULL;


SELECT 
    MONTH(issue_date) AS issue_month,
    COUNT(*) AS total_issues
FROM book_issues
WHERE YEAR(issue_date) = 2024
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);


select
l.library_name,
l.library_code,
count(b.issue_id) as total_issues
from libraries l
join book_issues b
group by 
l.library_name,
l.library_code
order by total_issues desc
limit 1;


select fund_year, sum(total_funds) as total_funds_allocated
from funds
group by fund_year
order by fund_year;


SELECT
    l.library_name,
    f.fund_year,
    f.total_funds,
    f.spent,
    ROUND((f.spent / f.total_funds) * 100, 2) AS utilization_percentage
FROM funds f
JOIN libraries l
    ON f.library_id = l.library_id
WHERE f.spent > 0.75 * f.total_funds
ORDER BY utilization_percentage DESC;


SELECT
    l.library_name,
    f.fund_year,
    f.total_funds,
    f.spent,
    ROUND((f.spent / f.total_funds) * 100, 2) AS utilization_percentage
FROM funds f
JOIN libraries l
    ON f.library_id = l.library_id
order by utilization_percentage desc;


SELECT
    l.library_name,
    f.fund_year,
    f.remaining,
    RANK() OVER (
        PARTITION BY f.fund_year
        ORDER BY f.remaining DESC
    ) AS fund_rank
FROM funds f
JOIN libraries l
    ON f.library_id = l.library_id
ORDER BY f.fund_year, fund_rank;


select
l.library_name,
l.library_code,
f.remaining
from libraries l
join funds f
on l.library_id = f.library_id
where f.remaining <= 0;


SELECT
    l.library_name,
    ROUND(AVG(f.total_funds), 2) AS avg_annual_funding
FROM funds f
JOIN libraries l
    ON f.library_id = l.library_id
GROUP BY l.library_id, l.library_name
ORDER BY avg_annual_funding DESC;


SELECT
    l.library_name,
    COUNT(DISTINCT b.book_id)     AS total_books,
    COUNT(DISTINCT r.reader_id)   AS total_readers,
    COUNT(DISTINCT e.employee_id) AS total_employees
FROM libraries l
LEFT JOIN books b
    ON l.library_id = b.library_id
LEFT JOIN readers r
    ON l.library_id = r.library_id
LEFT JOIN employees e
    ON l.library_id = e.library_id
GROUP BY l.library_id, l.library_name
ORDER BY l.library_name;


SELECT 
    l.library_name,
    COUNT(DISTINCT r.reader_id) AS total_readers,
    COUNT(DISTINCT b.book_id) AS total_books,
    ROUND(
        (COUNT(DISTINCT r.reader_id) / NULLIF(COUNT(DISTINCT b.book_id), 0)) * 100,
        2
    ) AS reader_to_book_ratio
FROM libraries l
LEFT JOIN readers r
    ON l.library_id = r.library_id 
LEFT JOIN books b
    ON l.library_id = b.library_id
GROUP BY 
    l.library_id,
    l.library_name
ORDER BY l.library_name;


select
b.genre,
count(bi.issue_id) as total_issues
from books b
join book_issues bi
on b.book_id = bi.book_id
group by 
b.genre
order by total_issues desc
limit 1;


select
b.title,
count(bi.book_id) as total_issues
from book_issues bi
join books b
on bi.book_id = b.book_id
group by
b.title,
b.book_id
order by total_issues desc
limit 1;


   SELECT
    l.library_id,
    l.library_name,
    COUNT(DISTINCT bi.issue_id) AS total_issues,
    COUNT(DISTINCT e.employee_id) AS total_staff
FROM libraries l
LEFT JOIN books b
    ON l.library_id = b.library_id
LEFT JOIN book_issues bi
    ON b.book_id = bi.book_id
LEFT JOIN employees e
    ON l.library_id = e.library_id
GROUP BY l.library_id, l.library_name
HAVING COUNT(DISTINCT bi.issue_id) > COUNT(DISTINCT e.employee_id);


SELECT
    l.library_id,
    l.library_name,
    SUM(bi.fine_amount) AS total_fine_collected
FROM libraries l
JOIN books b
    ON l.library_id = b.library_id
JOIN book_issues bi
    ON b.book_id = bi.book_id
GROUP BY
    l.library_id,
    l.library_name
ORDER BY
    total_fine_collected DESC;
   
   
SELECT
    l.library_name,
    b.book_id,
    b.title,
    COUNT(bi.issue_id) AS issue_count,
    RANK() OVER (
        PARTITION BY l.library_name
        ORDER BY COUNT(bi.issue_id) DESC
    ) AS book_rank
FROM libraries l
JOIN books b
    ON l.library_id = b.library_id
LEFT JOIN book_issues bi
    ON b.book_id = bi.book_id
GROUP BY
    l.library_id,
    l.library_name,
    b.book_id,
    b.title
ORDER BY
    l.library_name,
    book_rank;
    
    
SELECT
    month,
    monthly_fine,
    SUM(monthly_fine) OVER (ORDER BY month) AS running_total
FROM (
    SELECT
        DATE_FORMAT(issue_date, '%Y-%m') AS month,
        SUM(fine_amount) AS monthly_fine
    FROM book_issues
    WHERE fine_amount > 0
    GROUP BY DATE_FORMAT(issue_date, '%Y-%m')
) t
ORDER BY month;


SELECT
    b.genre,
    ROUND(AVG(DATEDIFF(bi.return_date, bi.issue_date)), 2) AS avg_issue_days
FROM book_issues bi
JOIN books b
    ON bi.book_id = b.book_id
WHERE bi.return_date IS NOT NULL
GROUP BY b.genre
ORDER BY avg_issue_days DESC;


WITH library_metrics AS (
    SELECT
        l.library_id,
        l.library_name,
        COUNT(DISTINCT b.book_id) AS total_books,
        COUNT(DISTINCT r.reader_id) AS total_readers,
        COUNT(bi.issue_id) AS total_issues,
        SUM(f.remaining) AS total_remaining_funds
    FROM libraries l
    LEFT JOIN books b ON l.library_id = b.library_id
    LEFT JOIN readers r ON l.library_id = r.library_id
    LEFT JOIN book_issues bi ON b.book_id = bi.book_id
    LEFT JOIN funds f ON l.library_id = f.library_id
    GROUP BY l.library_id, l.library_name
)
SELECT
    library_name,
    total_books,
    total_readers,
    total_issues,
    total_remaining_funds,
    
    -- Simple scoring (sum of metrics, scaled)
    RANK() OVER (ORDER BY 
        total_books * 0.25 +
        total_readers * 0.25 +
        total_issues * 0.30 +
        total_remaining_funds * 0.20 DESC
    ) AS library_rank
FROM library_metrics
ORDER BY library_rank;
































