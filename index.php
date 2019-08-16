<?php
require('helpers.php');

$is_auth = rand(0, 1);
$user_name = 'Сергей'; // укажите здесь ваше имя
$pageTitle = 'Главная';
$lot_categories = [
    10 => 'Доски и лыжи', 
    20 => 'Крепления', 
    30 => 'Ботинки', 
    40 => 'Одежда', 
    50 => 'Инструменты', 
    60 => 'Разное'
];
$lots = [
    [
        'name'      => '2014 Rossignol District Snowboard',
        'category'  => 10,
        'price'     => 10999,
        'image_url' => 'img/lot-1.jpg',
        'exp_date'   => '2019-08-17'
    ],
    [
        'name'      => 'DC Ply Mens 2016/2017 Snowboard',
        'category'  => 10,
        'price'     => 159999,
        'image_url' => 'img/lot-2.jpg',
        'exp_date'  => '2019-08-18'
    ],
    [
        'name'      => 'Крепления Union Contact Pro 2015 года размер L/XL',
        'category'  => 20,
        'price'     => 8000,
        'image_url' => 'img/lot-3.jpg',
        'exp_date'  => '2019-08-19'
    ],
    [
        'name'      => 'Ботинки для сноуборда DC Mutiny Charocal',
        'category'  => 30,
        'price'     => 10999,
        'image_url' => 'img/lot-4.jpg',
        'exp_date'  => '2019-08-20'
    ],
    [
        'name'      => 'Куртка для сноуборда DC Mutiny Charocal',
        'category'  => 40,
        'price'     => 7500,
        'image_url' => 'img/lot-5.jpg',
        'exp_date'  => '2019-08-21'
    ],
    [
        'name'      => 'Маска Oakley Canopy',
        'category'  => 60,
        'price'     => 5400,
        'image_url' => 'img/lot-6.jpg',
        'exp_date'  => '2019-08-22'
    ],
];

function price_opt($input) {
    $input = ceil($input);
    if ($input >= 1000) $input = number_format($input, 0, '', ' ');
    return $input . ' ₽';
}

function get_dt_range($input) {
   $hours = floor((strtotime($input)-strtotime('now'))/3600); //получаем округленное количество часов до завершения аукциона
   $minutes = floor((strtotime($input)-strtotime('now'))/60)%$hours; //получаем округленное количество минут до завершения аукциона
   //ранее минуты вычислялись во так: date_interval_format(date_diff(date_create('now'),date_create($input)), '%I')
   $hoursWith0 = str_pad($hours, 2, "0", STR_PAD_LEFT); //добавляем 0 в начале, если часов меньше 10
   return [$hoursWith0, $minutes]; //возвращаем в виде массива
}

$content = include_template('main.php', ['lot_categories' => $lot_categories, 'lots' => $lots]);
print(include_template('layout.php', ['pageTitle' => $pageTitle, 
                                    'pageContent' => $content, 
                                      'user_name' => $user_name, 
                                        'is_auth' => $is_auth] )
);  

?>