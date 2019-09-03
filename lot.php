<?php

require('helpers.php');

if (isset($_GET['lot_id'])) $lot_id = $_GET['lot_id']; 
	else {http_response_code(404); die();}

function get_dt_range($input) {
   $hours   = floor((strtotime($input)-strtotime('now'))/3600);
   $minutes = date_interval_format(date_diff(date_create('now'),date_create($input)), '%I');
   $hours   = str_pad($hours, 2, "0", STR_PAD_LEFT);
   $minutes = str_pad($minutes, 2, "0", STR_PAD_LEFT);
   return [$hours, $minutes];
}

$link = mysqli_connect("localhost", "root", "", "yeticave");

$sql  = "SELECT * FROM lots WHERE id = $lot_id";
$res  = mysqli_query($link, $sql);
$lot = mysqli_fetch_all($res, MYSQLI_ASSOC);

if ($lot == NULL) {http_response_code(404); die();}

$category_id = intval($lot[0]['category_id']);
$sql  = "SELECT name FROM categories WHERE id = $category_id";
$res  = mysqli_query($link, $sql);
$category_name = mysqli_fetch_all($res, MYSQLI_ASSOC);

print(include_template('lot.php', ['lot' => $lot, 'category' => $category_name]));

?>