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
    ],
    [
        'name'      => 'DC Ply Mens 2016/2017 Snowboard',
        'category'  => 10,
        'price'     => 159999,
        'image_url' => 'img/lot-2.jpg',
    ],
    [
        'name'      => 'Крепления Union Contact Pro 2015 года размер L/XL',
        'category'  => 20,
        'price'     => 8000,
        'image_url' => 'img/lot-3.jpg',
    ],
    [
        'name'      => 'Ботинки для сноуборда DC Mutiny Charocal',
        'category'  => 30,
        'price'     => 10999,
        'image_url' => 'img/lot-4.jpg',
    ],
    [
        'name'      => 'Куртка для сноуборда DC Mutiny Charocal',
        'category'  => 40,
        'price'     => 7500,
        'image_url' => 'img/lot-5.jpg',
    ],
    [
        'name'      => 'Маска Oakley Canopy',
        'category'  => 60,
        'price'     => 5400,
        'image_url' => 'img/lot-6.jpg',
    ],
];
function price_opt($input) {
    $input = ceil($input);
    if ($input >= 1000) $input = number_format($input, 0, '', ' ');
    return $input . ' ₽';
}

$content = include_template('main.php', ['lot_categories' => $lot_categories, 'lots' => $lots]);
print(include_template('layout.php', ['pageTitle' => $pageTitle, 
                                    'pageContent' => $content, 
                                      'user_name' => $user_name, 
                                        'is_auth' => $is_auth] )
);  

?>