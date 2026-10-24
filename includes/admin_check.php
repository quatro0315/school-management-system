<?php

if ((int)($_SESSION['usertype_id'] ?? 0) !== 1) {
    $_SESSION['flash'] = ['type' => 'error', 'message' => 'You do not have permission to access that page.'];
    header("Location: dashboard.php");
    exit;
}
