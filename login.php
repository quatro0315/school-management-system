<?php
require_once __DIR__ . '/config.php';

// Redirect users who are already logged in.
if (!empty($_SESSION['user_id'])) {
    header('Location: /dashboard.php');
    exit;
}

$error = '';
$flash = $_SESSION['flash'] ?? null;
unset($_SESSION['flash']);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($username === '' || $password === '') {
        $error = 'Please enter both username and password.';
    } else {
        try {
            $stmt = $pdo->prepare("
                SELECT
                    u.*,
                    ut.Usertype AS USERTYPE_NAME
                FROM tbl_users u
                LEFT JOIN tbl_usertype ut
                    ON ut.ID = u.tbl_usertype_id
                WHERE u.USERNAME = ?
                LIMIT 1
            ");

            $stmt->execute([$username]);
            $user = $stmt->fetch();

            if (
                $user &&
                isset($user['PASSWORD']) &&
                password_verify($password, $user['PASSWORD'])
            ) {
                // Create a new session ID after successful authentication.
                session_regenerate_id(true);

                $_SESSION['user_id'] = $user['ID'];
                $_SESSION['username'] = $user['USERNAME'];
                $_SESSION['fullname'] =
                    !empty($user['FULLNAME'])
                        ? $user['FULLNAME']
                        : $user['USERNAME'];

                $_SESSION['usertype_id'] = $user['tbl_usertype_id'];
                $_SESSION['usertype_name'] =
                    $user['USERTYPE_NAME'] ?? 'User';

                // Redirect after setting session values.
                header('Location: /dashboard.php');
                exit;
            }

            $error = 'Invalid username or password.';

        } catch (Throwable $e) {
            // Keep technical details in server logs, not on the login page.
            error_log('Login error: ' . $e->getMessage());
            $error = 'Unable to log in right now. Please try again later.';
        }
    }
}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Management System</title>
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body class="login-body">
    <div class="login-card">
        <div class="login-brand">
            <span class="brand-icon">🎓</span>
            <h1>Student Management System</h1>
            <p>Sign in to continue</p>
        </div>

        <?php if ($flash): ?>
            <div class="alert alert-<?= htmlspecialchars(
                $flash['type'] ?? 'info',
                ENT_QUOTES,
                'UTF-8'
            ) ?>">
                <?= htmlspecialchars(
                    $flash['message'] ?? '',
                    ENT_QUOTES,
                    'UTF-8'
                ) ?>
            </div>
        <?php endif; ?>

        <?php if ($error !== ''): ?>
            <div class="alert alert-error">
                <?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?>
            </div>
        <?php endif; ?>

        <form method="POST" action="/login.php" class="login-form">
            <label for="username">Username</label>
            <input
                type="text"
                id="username"
                name="username"
                placeholder="Enter username"
                autocomplete="username"
                required
                autofocus
                value="<?= htmlspecialchars(
                    $_POST['username'] ?? '',
                    ENT_QUOTES,
                    'UTF-8'
                ) ?>"
            >

            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter password"
                autocomplete="current-password"
                required
            >

            <button type="submit" class="btn btn-primary btn-block">
                Log In
            </button>
        </form>

        <p class="login-hint">
            Don't have an account?
            <a href="/register.php">Sign up</a>
        </p>
    </div>
</body>
</html>
