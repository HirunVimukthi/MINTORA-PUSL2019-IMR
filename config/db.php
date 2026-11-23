<?php
/**
 * Shared PDO database connection for MINTORA.
 */

$host = '127.0.0.1';
$port = '3306';
$database = 'mintora_db';
$username = 'root';
$password = '';
$charset = 'utf8mb4';

$dsn = "mysql:host={$host};port={$port};dbname={$database};charset={$charset}";

try {
    $pdo = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $exception) {
    // Keep the database error from exposing credentials or connection details.
    $pdo = null;
}
