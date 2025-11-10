<?php
// clients/php/index.php
// Use PDO with exceptions and utf8mb4 charset.
$dsn = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',
    getenv('DB_HOST') ?: 'localhost', getenv('DB_PORT') ?: '3306', getenv('DB_NAME') ?: 'app_db');
$pdo = new PDO($dsn, getenv('DB_USER') ?: 'app', getenv('DB_PASSWORD') ?: 'app_password', [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
]);
$stmt = $pdo->query('SELECT NOW() AS now');
var_dump($stmt->fetchAll(PDO::FETCH_ASSOC));
