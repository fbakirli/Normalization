DROP TABLE IF EXISTS unnorm CASCADE;
DROP TABLE IF EXISTS books_1nf CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS relation CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;
DROP TABLE IF EXISTS isbn_authors CASCADE;


CREATE TABLE unnorm (
    CRN INT,
    ISBN INT,
    Title VARCHAR(255),
    Authors VARCHAR(255),
    Edition INT,
    Publisher VARCHAR(255),
    Publisher_Address VARCHAR(255),
    Pages INT,
    Years INT,
    Course_Name VARCHAR(255),
    PRIMARY KEY (CRN, ISBN) 
	);

COPY unnorm (CRN, ISBN, Title, Authors, Edition, Publisher, Publisher_Address, Pages, Years, Course_Name)
FROM 'D:\Downloads\Unnormalized1.csv'
DELIMITER ',' CSV HEADER ENCODING 'ISO-8859-1';

----1NF
CREATE TABLE books_1NF AS
SELECT 
    CRN, 
    ISBN, 
    Title,
    UNNEST(string_to_array(Authors, ',')) AS Author,
    Edition,
    Publisher,
	Publisher_Address,
    Pages, 
    Years, 
    Course_Name
FROM unnorm;

-------------------------------------------

----2NF
CREATE TABLE courses AS
SELECT DISTINCT 
    CRN, 
    Course_Name
FROM books_1NF;


CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(255) 
);

INSERT INTO authors (author_name)
SELECT DISTINCT Author 
FROM books_1NF
ORDER BY Author;


CREATE TABLE isbn_authors AS
SELECT DISTINCT
    b.ISBN,
    a.author_id
FROM books_1NF b
JOIN authors a
ON b.Author = a.author_name;



CREATE TABLE relation AS
SELECT DISTINCT 
    CRN, 
    ISBN
FROM books_1NF;

CREATE TABLE books AS
SELECT DISTINCT 
    ISBN, 
    Title, 
    Edition, 
    Publisher,
    Publisher_Address,
    Pages, 
    Years
FROM books_1NF;


ALTER TABLE courses
ADD CONSTRAINT pk_courses PRIMARY KEY (CRN);

ALTER TABLE books
ADD CONSTRAINT pk_books PRIMARY KEY (ISBN);

ALTER TABLE relation
ADD CONSTRAINT pk_relation PRIMARY KEY (CRN, ISBN);

ALTER TABLE relation
ADD CONSTRAINT fk_relation_courses FOREIGN KEY (CRN)
REFERENCES courses(CRN);

ALTER TABLE relation
ADD CONSTRAINT fk_relation_books FOREIGN KEY (ISBN)
REFERENCES books(ISBN);



ALTER TABLE isbn_authors
ADD CONSTRAINT pk_isbn_authors PRIMARY KEY (isbn, author_id);


ALTER TABLE isbn_authors
ADD CONSTRAINT fk_isbn_authors_books FOREIGN KEY (isbn)
REFERENCES books(ISBN);


ALTER TABLE isbn_authors
ADD CONSTRAINT fk_isbn_authors_authors FOREIGN KEY (author_id)
REFERENCES authors(author_id);

--------2nf done-------------------

------3nf

CREATE TABLE publishers AS
SELECT DISTINCT 
    Publisher, 
    Publisher_Address
FROM books;

ALTER TABLE publishers ADD COLUMN Publisher_ID SERIAL PRIMARY KEY;

ALTER TABLE books ADD COLUMN Publisher_ID INT;

UPDATE books
SET Publisher_ID = (
    SELECT Publisher_ID
    FROM publishers
    WHERE publishers.Publisher = books.Publisher
);

ALTER TABLE books DROP COLUMN Publisher;
ALTER TABLE books DROP COLUMN Publisher_Address;


