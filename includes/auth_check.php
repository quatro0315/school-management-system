
<?php

require_once __DIR__ . '/../config.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (empty($_SESSION['user_id'])) {
    header('Location: /login.php');
    exit;
}

require_once __DIR__ . '/permissions.php';

if (!canAccessPage($_SERVER['PHP_SELF'])) {
    denyAccess();
    exit;
}
