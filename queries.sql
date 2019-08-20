/* Заполняем таблицу с категориями */
INSERT INTO categories (NAME, CODE) VALUES ('Доски и лыжи', 'boards');
INSERT INTO categories (NAME, CODE) VALUES ('Крепления', 'attachment');
INSERT INTO categories (NAME, CODE) VALUES ('Ботинки', 'boots');
INSERT INTO categories (NAME, CODE) VALUES ('Одежда', 'clothing');
INSERT INTO categories (NAME, CODE) VALUES ('Инструменты', 'tools');
INSERT INTO categories (NAME, CODE) VALUES ('Разное', 'other');

/* Заполняем таблицу с пользователями */
INSERT INTO users (email, NAME, PASSWORD, avatar, contact) VALUES ('ivan@yandex.ru', 'Иван', 'qwerty', 'img/ivan.jpg', '89001234567');
INSERT INTO users (email, NAME, PASSWORD, avatar, contact) VALUES ('oleg@yandex.ru', 'Олег', 'passpass', 'img/oleg.jpg', '89007654321');

/* Заполняем таблицу с существующими объявлениями */
INSERT INTO lots (date_create, NAME, description, image_url, price_start, date_close, price_step, user_creator_id, category_id)
VALUES ('2019-08-12','2014 Rossignol District Snowboard', 'Сноуборд', 'img/lot-1.jpg', 10999, '2019-08-17', 100, 1, 1); 
INSERT INTO lots (date_create, NAME, description, image_url, price_start, date_close, price_step, user_creator_id, category_id)
VALUES ('2019-08-13','DC Ply Mens 2016/2017 Snowboard', 'Отличный сноуборд', 'img/lot-2.jpg', 159999, '2019-08-18', 1000, 2, 1); 
INSERT INTO lots (date_create, NAME, description, image_url, price_start, date_close, price_step, user_creator_id, category_id)
VALUES ('2019-08-14','Крепления Union Contact Pro 2015 года размер L/XL', 'Крепления', 'img/lot-3.jpg', 8000, '2019-08-19', 200, 2, 2); 
INSERT INTO lots (date_create, NAME, description, image_url, price_start, date_close, price_step, user_creator_id, category_id)
VALUES ('2019-08-15','Ботинки для сноуборда DC Mutiny Charocal', 'Хорошие ботинки', 'img/lot-4.jpg', 10999, '2019-08-20', 99, 1, 3); 
INSERT INTO lots (date_create, NAME, description, image_url, price_start, date_close, price_step, user_creator_id, category_id)
VALUES ('2019-08-16','Куртка для сноуборда DC Mutiny Charocal', 'Тёплая куртка', 'img/lot-5.jpg', 7500, '2019-08-21', 500, 1, 4);
INSERT INTO lots (date_create, NAME, description, image_url, price_start, date_close, price_step, user_creator_id, category_id)
VALUES ('2019-08-17','Маска Oakley Canopy', 'Защитная маска', 'img/lot-6.jpg', 5400, '2019-08-22', 300, 2, 6);

/* Заполняем таблицу ставок */
INSERT INTO bets (date, price, user_id, lot_id) VALUES ('2019-08-18', 8000, 1, 6);
INSERT INTO bets (date, price, user_id, lot_id) VALUES ('2019-08-20', 8500, 2, 6); 

------------------

/* Запрос: получить все категории */
SELECT * FROM categories;
/* если имеллось ввиду только названия, то (с сортировкой по id) */
SELECT name FROM categories ORDER BY id;

/* Запрос: получить самые новые, открытые лоты. Каждый лот должен включать название, стартовую цену, ссылку на изображение, название категории */
SELECT date_create, lots.name, price_start, image_url, categories.name FROM lots
JOIN categories ON lots.category_id = categories.id 
WHERE (date_create > NOW() - INTERVAL 5 DAY) AND date_close > NOW();

/* Запрос: показать лот по его id. Получите также название категории, к которой принадлежит лот */
SELECT lots.*, categories.name FROM lots
JOIN categories ON lots.category_id = categories.id
WHERE lots.id=5;

/* Запрос: обновить название лота по его идентификатору */
UPDATE lots SET name = 'Маска Champion'
WHERE id = 7;

/* Запрос: получить список ставок для лота по его идентификатору с сортировкой по дате. */
SELECT bets.* FROM lots
JOIN bets ON bets.lot_id = lots.id
WHERE lots.id = 6 ORDER BY bets.DATE;