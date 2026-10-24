<?php
// Student Management System — Render/Aiven + local development configuration.
// This file must be saved as UTF-8 WITHOUT BOM. No closing PHP tag.
if (session_status() === PHP_SESSION_NONE) {
    session_set_cookie_params([
        'lifetime' => 0,
        'path' => '/',
        'secure' => !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off'
            || strtolower($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '') === 'https',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();
}

$production = (getenv('RENDER') !== false) || (getenv('DB_HOST') !== false);
$host = getenv('DB_HOST') ?: ($production ? '' : 'localhost');
$port = (int) (getenv('DB_PORT') ?: 3306);
$name = getenv('DB_NAME') ?: ($production ? '' : 'student_db');
$user = getenv('DB_USER') ?: ($production ? '' : 'root');
$pass = getenv('DB_PASSWORD');
if ($pass === false) $pass = $production ? null : '';
$ca = getenv('DB_SSL_CA_PATH') ?: ($production ? '/etc/secrets/ca.pem' : '');

// Existing code may reference these constants.
define('DB_HOST', $host);
define('DB_NAME', $name);
define('DB_USER', $user);
define('DB_PASS', $pass ?? '');
define('ALLOW_ROLE_SELECTION_ON_SIGNUP', false);

try {
    if ($host === '' || $name === '' || $user === '' || $pass === null) {
        throw new RuntimeException('Required database environment variables are missing.');
    }
    $opts = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ];
    if ($production) {
        if (!is_file($ca) || !is_readable($ca)) {
            throw new RuntimeException('Aiven CA certificate cannot be read at ' . $ca);
        }
        $opts[PDO::MYSQL_ATTR_SSL_CA] = $ca;
        $opts[PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT] = true;
    }
    $pdo = new PDO(
        'mysql:host=' . $host . ';port=' . $port . ';dbname=' . $name . ';charset=utf8mb4',
        $user,
        $pass,
        $opts
    );
} catch (Throwable $e) {
    error_log('Database connection error: ' . $e->getMessage());
    http_response_code(503);
    exit('Database connection unavailable. Please contact the administrator.');
}
