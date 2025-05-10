USE MASTER
GO
DROP DATABASE IF EXISTS LGraph
GO
CREATE DATABASE LGraph
GO
USE LGraph
GO

-- Пользователи
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    JoinDate DATE,
    Country NVARCHAR(50)
) AS NODE;

-- Книги
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Genre NVARCHAR(50),
    PublishedYear INT
) AS NODE;

-- Авторы
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50)
) AS NODE;

-- Дружба между пользователями
CREATE TABLE Friends (
    FriendsSince DATE
) AS EDGE;

-- Рекомендации книг
CREATE TABLE Recommends (
    Rating INT CHECK (Rating BETWEEN 1 AND 5)
) AS EDGE;

-- Книги, написанные авторами
CREATE TABLE WrittenBy AS EDGE;

INSERT INTO Users (UserID, Username, JoinDate, Country) VALUES
(1, 'BookLover42', '20-01-15', 'Беларусь'),
(2, 'LiteraryFan', '19-05-22', 'Россия'),
(3, 'PageTurner', '21-03-10', 'Украина'),
(4, 'ReadAndRelax', '20-11-30', 'Польша'),
(5, 'ClassicReader', '18-07-14', 'Россия'),
(6, 'FantasyExplorer', '22-02-28', 'Беларусь'),
(7, 'SciFiEnthusiast', '21-09-05', 'Литва'),
(8, 'MysteryLover', '20-04-18', 'Украина'),
(9, 'NonfictionGuru', '19-12-01', 'Польша'),
(10, 'PoetryAdmirer', '21-07-22', 'Латвия');

INSERT INTO Books (BookID, Title, Genre, PublishedYear) VALUES
(1, '1984', 'Антиутопия', 1949),
(2, 'Мастер и Маргарита', 'Роман', 1967),
(3, 'Преступление и наказание', 'Классика', 1866),
(4, 'Гарри Поттер и философский камень', 'Фэнтези', 1997),
(5, 'Властелин колец', 'Фэнтези', 1954),
(6, 'Тень горы', 'Приключения', 15),
(7, 'Атлант расправил плечи', 'Философия', 1957),
(8, 'Маленький принц', 'Притча', 1943),
(9, 'Собачье сердце', 'Сатира', 1925),
(10, 'Шерлок Холмс: Собака Баскервилей', 'Детектив', 1902);

INSERT INTO Authors (AuthorID, Name, Country) VALUES
(1, 'Джордж Оруэлл', 'Великобритания'),
(2, 'Михаил Булгаков', 'Россия'),
(3, 'Фёдор Достоевский', 'Россия'),
(4, 'Джоан Роулинг', 'Великобритания'),
(5, 'Дж. Р. Р. Толкин', 'Великобритания'),
(6, 'Грегори Дэвид Робертс', 'Австралия'),
(7, 'Айн Рэнд', 'США'),
(8, 'Антуан де Сент-Экзюпери', 'Франция'),
(9, 'Артур Конан Дойл', 'Великобритания'),
(10, 'Эрих Мария Ремарк', 'Германия');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 1), (SELECT $node_id FROM Users WHERE UserID = 2), '21-02-10'),
((SELECT $node_id FROM Users WHERE UserID = 2), (SELECT $node_id FROM Users WHERE UserID = 1),'21-02-10');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 1), (SELECT $node_id FROM Users WHERE UserID = 3), '20-11-05'),
((SELECT $node_id FROM Users WHERE UserID = 3), (SELECT $node_id FROM Users WHERE UserID = 1), '20-11-05');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 2), (SELECT $node_id FROM Users WHERE UserID = 4), '19-08-15'),
((SELECT $node_id FROM Users WHERE UserID = 4), (SELECT $node_id FROM Users WHERE UserID = 2), '19-08-15');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 3), (SELECT $node_id FROM Users WHERE UserID = 5), '21-04-20'),
((SELECT $node_id FROM Users WHERE UserID = 5), (SELECT $node_id FROM Users WHERE UserID = 3), '21-04-20');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 4), (SELECT $node_id FROM Users WHERE UserID = 6), '22-01-12'),
((SELECT $node_id FROM Users WHERE UserID = 6), (SELECT $node_id FROM Users WHERE UserID = 4), '22-01-12');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 5), (SELECT $node_id FROM Users WHERE UserID = 7), '20-09-30'),
((SELECT $node_id FROM Users WHERE UserID = 7), (SELECT $node_id FROM Users WHERE UserID = 5), '20-09-30');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 6), (SELECT $node_id FROM Users WHERE UserID = 8), '21-07-18'),
((SELECT $node_id FROM Users WHERE UserID = 8), (SELECT $node_id FROM Users WHERE UserID = 6), '21-07-18');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 7), (SELECT $node_id FROM Users WHERE UserID = 9), '22-03-05'),
((SELECT $node_id FROM Users WHERE UserID = 9), (SELECT $node_id FROM Users WHERE UserID = 7),'22-03-05');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 8), (SELECT $node_id FROM Users WHERE UserID = 10), '20-12-25'),
((SELECT $node_id FROM Users WHERE UserID = 10), (SELECT $node_id FROM Users WHERE UserID = 8), '20-12-25');

INSERT INTO Friends ($from_id, $to_id, FriendsSince) VALUES
((SELECT $node_id FROM Users WHERE UserID = 1), (SELECT $node_id FROM Users WHERE UserID = 9), '21-10-14'),
((SELECT $node_id FROM Users WHERE UserID = 9), (SELECT $node_id FROM Users WHERE UserID = 1), '21-10-14');


INSERT INTO Recommends ($from_id, $to_id, Rating) VALUES
-- Пользователь 1 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 1), (SELECT $node_id FROM Books WHERE BookID = 1), 5),
((SELECT $node_id FROM Users WHERE UserID = 1), (SELECT $node_id FROM Books WHERE BookID = 4), 4),

-- Пользователь 2 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 2), (SELECT $node_id FROM Books WHERE BookID = 2), 5),
((SELECT $node_id FROM Users WHERE UserID = 2), (SELECT $node_id FROM Books WHERE BookID = 5), 3),

-- Пользователь 3 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 3), (SELECT $node_id FROM Books WHERE BookID = 3), 4),
((SELECT $node_id FROM Users WHERE UserID = 3), (SELECT $node_id FROM Books WHERE BookID = 1), 4),

-- Пользователь 4 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 4), (SELECT $node_id FROM Books WHERE BookID = 6), 5),

-- Пользователь 5 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 5), (SELECT $node_id FROM Books WHERE BookID = 7), 2),

-- Пользователь 6 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 6), (SELECT $node_id FROM Books WHERE BookID = 8), 5),

-- Пользователь 7 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 7), (SELECT $node_id FROM Books WHERE BookID = 9), 4),

-- Пользователь 9 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 9), (SELECT $node_id FROM Books WHERE BookID = 4), 4),

-- Пользователь 8 рекомендует книги
((SELECT $node_id FROM Users WHERE UserID = 8), (SELECT $node_id FROM Books WHERE BookID = 10), 5);



INSERT INTO WrittenBy ($from_id, $to_id) VALUES
((SELECT $node_id FROM Books WHERE BookID = 1), (SELECT $node_id FROM Authors WHERE AuthorID = 1)), -- 1984 - Оруэлл
((SELECT $node_id FROM Books WHERE BookID = 2), (SELECT $node_id FROM Authors WHERE AuthorID = 2)), -- Мастер и Маргарита - Булгаков
((SELECT $node_id FROM Books WHERE BookID = 3), (SELECT $node_id FROM Authors WHERE AuthorID = 3)), -- Преступление и наказание - Достоевский
((SELECT $node_id FROM Books WHERE BookID = 4), (SELECT $node_id FROM Authors WHERE AuthorID = 4)), -- Гарри Поттер - Роулинг
((SELECT $node_id FROM Books WHERE BookID = 5), (SELECT $node_id FROM Authors WHERE AuthorID = 5)), -- Властелин колец - Толкин
((SELECT $node_id FROM Books WHERE BookID = 6), (SELECT $node_id FROM Authors WHERE AuthorID = 6)), -- Тень горы - Робертс
((SELECT $node_id FROM Books WHERE BookID = 7), (SELECT $node_id FROM Authors WHERE AuthorID = 7)), -- Атлант расправил плечи - Рэнд
((SELECT $node_id FROM Books WHERE BookID = 8), (SELECT $node_id FROM Authors WHERE AuthorID = 8)), -- Маленький принц - Сент-Экзюпери
((SELECT $node_id FROM Books WHERE BookID = 9), (SELECT $node_id FROM Authors WHERE AuthorID = 2)), -- Собачье сердце - Булгаков
((SELECT $node_id FROM Books WHERE BookID = 10), (SELECT $node_id FROM Authors WHERE AuthorID = 9)); -- Шерлок Холмс - Конан Дойл

-- Найти всех друзей пользователя с именем 'BookLover42'
SELECT U1.Username AS UserName, U2.Username AS FriendName
FROM Users AS U1
    , Friends AS F
    , Users AS U2
WHERE MATCH(U1-(F)->U2)
    AND U1.Username = 'BookLover42';

-- Найти все книги, рекомендованные пользователем 'LiteraryFan'
SELECT U.Username, B.Title AS RecommendedBook
FROM Users AS U
    , Recommends AS R
    , Books AS B
WHERE MATCH(U-(R)->B)
    AND U.Username = 'LiteraryFan';	

-- Найти всех авторов, чьи книги рекомендовал пользователь 'PageTurner'
SELECT U.Username, A.Name AS AuthorName
FROM Users AS U
    , Recommends AS R
    , Books AS B
    , WrittenBy AS W
    , Authors AS A
WHERE MATCH(U-(R)->B-(W)->A)
    AND U.Username = 'PageTurner';

-- Найти друзей пользователя 'ClassicReader', которые рекомендуют книги жанра 'Классика'
SELECT U1.Username AS UserName, U2.Username AS FriendName, B.Title AS ClassicBook
FROM Users AS U1
    , Friends AS F
    , Users AS U2
    , Recommends AS R
    , Books AS B
WHERE MATCH(U1-(F)->U2-(R)->B)
    AND U1.Username = 'ClassicReader'
    AND B.Genre = 'Классика';

-- Найти пользователей, которые рекомендуют книги автора 'Михаил Булгаков'
SELECT U.Username, B.Title AS BookTitle
FROM Users AS U
    , Recommends AS R
    , Books AS B
    , WrittenBy AS W
    , Authors AS A
WHERE MATCH(U-(R)->B-(W)->A)
    AND A.Name = 'Михаил Булгаков';

SELECT 
    User1.Username AS Recommender,
    STRING_AGG(User2.Username, ' -> ') WITHIN GROUP (GRAPH PATH) AS RecommendationChain,
    STRING_AGG(Book.Title, ' -> ') WITHIN GROUP (GRAPH PATH) AS BooksRecommended
FROM 
    Users AS User1,
    Recommends FOR PATH AS r1,
    Books FOR PATH AS Book,
    Recommends FOR PATH AS r2,
    Users FOR PATH AS User2
WHERE 
    MATCH(SHORTEST_PATH(User1(-(r1)->Book<-(r2)-User2)+))
    AND User1.UserID = 3; 

SELECT
    StartUser.Username AS StartUser,
    STRING_AGG(Friend.Username, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendshipPath
FROM
    Users AS StartUser,
    Friends FOR PATH AS f,
    Users FOR PATH AS Friend
WHERE
    MATCH(SHORTEST_PATH(StartUser(-(f)->Friend){1,3}))
    AND StartUser.Username = 'BookLover42';

SELECT U1.UserId AS IdFirst
	, U1.username AS First
	, CONCAT(N'user (', U1.UserId, ')') AS [First image name]
	, U2.UserId AS IdSecond
	, U2.Username AS Second
	, CONCAT(N'user (', U2.UserId, ')') AS [Second image name]
FROM Users AS U1
	, Friends AS f
	, Users AS U2
WHERE MATCH(U1-(f)->U2)

SELECT U.UserId AS IdFirst
	, U.Username AS First
	, CONCAT(N'user (', U.UserId, ')') AS [First image name]
	, B.BookId AS IdSecond
	, B.title AS Second
	, CONCAT(N'book (', B.BookId, ')') AS [Second image name]
FROM Users AS U
	, Recommends AS r
	, Books AS B
WHERE MATCH(U-(r)->B)

SELECT B.BookId AS IdFirst
	, B.title AS First
	, CONCAT(N'book (', B.BookId, ')') AS [First image name]
	, A.AuthorId AS IdSecond
	, A.name AS Second
	, CONCAT(N'author (', A.AuthorId, ')') AS [Second image name]
FROM Authors AS A
	, WrittenBy AS wb
	, Books AS B
WHERE MATCH(B-(wb)->A)