<?php

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

require_once __DIR__ . '/permissions.php';

if (!canAccessPage($_SERVER['PHP_SELF'])) {
    denyAccess();
}
