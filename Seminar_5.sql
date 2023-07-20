DROP DATABASE IF EXISTS seminar_5;
CREATE DATABASE IF NOT EXISTS seminar_5;
USE seminar_5;
CREATE TABLE IF NOT EXISTS cars 
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);
TRUNCATE cars;
INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
-- Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE VIEW viev1 AS 
SELECT * FROM cars WHERE cost < 25000;
SELECT * FROM viev1;
-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор OR REPLACE)
CREATE OR REPLACE VIEW viev1 AS 
SELECT * FROM cars WHERE cost < 30000;
SELECT * FROM viev1;
-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW viev2 AS 
SELECT * FROM cars WHERE name = 'Audi' OR name = 'Skoda';
SELECT * FROM viev2;
/* Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, мы вычитаем время станций для пар
смежных станций. Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.*/
CREATE TABLE IF NOT EXISTS station 
(id INT PRIMARY KEY AUTO_INCREMENT,
train_id INT NOT NULL,
station VARCHAR(20),
station_time TIME);
TRUNCATE station;
INSERT station (train_id, station, station_time)
VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Redwood City', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '12:35:00'),
(120, 'San Francisco', '11:00:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose', '13:30:00');
CREATE OR REPLACE VIEW view3 AS
SELECT train_id, station, station_time, LEAD(station_time)
OVER(PARTITION BY train_id) AS next_station FROM station;
SELECT train_id, station_time, timediff( next_station, station_time)  as time_to_next_station
FROM view3;


