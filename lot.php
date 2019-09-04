<?php

require('helpers.php');

if (isset($_GET['lot_id'])) $lot_id = intval($_GET['lot_id']); 
	else {http_response_code(404); die();}

$link = mysqli_connect("localhost", "root", "", "yeticave");

$sql  = "SELECT * FROM lots WHERE id = $lot_id";
$res  = mysqli_query($link, $sql);
$lot  = mysqli_fetch_all($res, MYSQLI_ASSOC);

if ($lot == NULL) {http_response_code(404); die();}

$sql  = "SELECT * FROM categories";
$res  = mysqli_query($link, $sql);
$categories = mysqli_fetch_all($res, MYSQLI_ASSOC);

print(include_template('lot.php', ['lot' => $lot, 'categories' => $categories]));

?>