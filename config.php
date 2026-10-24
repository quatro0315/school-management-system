
<?php
// Student Management System — Render/Aiven + Local Development
// Save as UTF-8 without BOM.

if (session_status() === PHP_SESSION_NONE) {
    session_set_cookie_params([
        'lifetime' => 0,
        'path' => '/',
        'secure' =>
            (
                !empty($_SERVER['HTTPS']) &&
                $_SERVER['HTTPS'] !== 'off'
            ) ||
            strtolower(
                $_SERVER['HTTP_X_FORWARDED_PROTO'] ?? ''
            ) === 'https',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);

    session_start();
}

// Detect production environment.
$production =
    getenv('RENDER') !== false ||
    getenv('DB_HOST') !== false;

// Read database environment variables.
$host = getenv('DB_HOST') ?: (
    $production ? '' : 'localhost'
);

$port = (int) (getenv('DB_PORT') ?: 3306);

$name = getenv('DB_NAME') ?: (
    $production ? '' : 'student_db'
);

$user = getenv('DB_USER') ?: (
    $production ? '' : 'root'
);

$pass = getenv('DB_PASSWORD');

if ($pass === false) {
    $pass = $production ? null : '';
}

// Aiven SSL certificate path.
$ca = getenv('DB_SSL_CA_PATH') ?: (
    $production ? '/etc/secrets/ca.pem' : ''
);

// Existing code may reference these constants.
if (!defined('DB_HOST')) {
    define('DB_HOST', $host);
}

if (!defined('DB_NAME')) {
    define('DB_NAME', $name);
}

if (!defined('DB_USER')) {
    define('DB_USER', $user);
}

if (!defined('DB_PASS')) {
    define('DB_PASS', $pass ?? '');
}

if (!defined('ALLOW_ROLE_SELECTION_ON_SIGNUP')) {
    define('ALLOW_ROLE_SELECTION_ON_SIGNUP', false);
}

try {
    // TEMPORARY DIAGNOSTICS:
    // Logs only whether values exist, never their actual contents.
    error_log('DB diagnostic: ' . json_encode([
        'DB_HOST_set' => $host !== '',
        'DB_PORT_set' => $port > 0,
        'DB_NAME_set' => $name !== '',
        'DB_USER_set' => $user !== '',
        'DB_PASSWORD_set' => $pass !== null,
        'RENDER_set' => getenv('RENDER') !== false,
        'production_mode' => $production,
    ]));

    // Check required credentials.
    if (
        $host === '' ||
        $name === '' ||
        $user === '' ||
        $pass === null
    ) {
        throw new RuntimeException(
            'Required database environment variables are missing.'
        );
    }

    // PDO connection options.
    $opts = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ];

    // Configure SSL for Aiven in production.
    if ($production) {
        if (!is_file($ca) || !is_readable($ca)) {
            throw new RuntimeException(
                'Aiven CA certificate cannot be read at ' . $ca
            );
        }

        $opts[PDO::MYSQL_ATTR_SSL_CA] = $ca;

        if (defined('PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT')) {
            $opts[PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT] = true;
        }
    }

    // Connect to MySQL.
    $dsn = 'mysql:host=' . $host
        . ';port=' . $port
        . ';dbname=' . $name
        . ';charset=utf8mb4';

    $pdo = new PDO(
        $dsn,
        $user,
        $pass,
        $opts
    );

} catch (Throwable $e) {
    // Log the actual error in Render logs.
    error_log(
        'Database connection error: ' . $e->getMessage()
    );

    http_response_code(503);

    exit(
        'Database connection unavailable. Please contact the administrator.'
    );
}
