<?php
require('helpers.php');

$is_auth = rand(0, 1);
$user_name = 'Сергей'; // укажите здесь ваше имя
$pageTitle = 'Главная';

function price_opt($input) {
    $input = ceil($input);
    if ($input >= 1000) $input = number_format($input, 0, '', ' ');
    return $input . ' ₽';
}

$link = mysqli_connect("localhost", "root", "", "yeticave");

//получаем новые лоты
$sql  = "SELECT * FROM lots ORDER BY date_create DESC";
$res  = mysqli_query($link, $sql);
$lots = mysqli_fetch_all($res, MYSQLI_ASSOC);

//получаем список категорий
$sql  = "SELECT * FROM categories ORDER BY name";
$res  = mysqli_query($link, $sql);
$temp_lot_categories = mysqli_fetch_all($res, MYSQLI_ASSOC);
foreach ($temp_lot_categories as $key => $value) {
    $lot_categories[$value['id']] = $temp_lot_categories[$key];
}

$content = include_template('main.php', ['lot_categories' => $lot_categories, 'lots' => $lots]);
print(include_template('layout.php', ['pageTitle' => $pageTitle, 
                                    'pageContent' => $content, 
                                      'user_name' => $user_name, 
                                        'is_auth' => $is_auth,
                                 'lot_categories' => $lot_categories] )
);  

?>