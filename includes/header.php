<?php
require_once __DIR__ . '/user_photo.php';

$displayName = $_SESSION['fullname'] ?? $_SESSION['username'] ?? 'User';
$currentPage = basename($_SERVER['PHP_SELF']);

$navGroups = [
    ['dashboard.php', '📊', 'Dashboard'],
    ['students.php',  '🧑‍🎓', 'Students', ['student_add.php', 'student_edit.php']],
    ['courses.php',   '🎓', 'Courses', ['course_edit.php']],
    ['schoolyears.php','📅', 'School Year', ['schoolyear_edit.php']],
    ['sections.php',  '👥', 'Section', ['section_edit.php']],
    ['terms.php',     '⏰', 'Term', ['term_edit.php']],
    ['yearlevels.php','⏳', 'Year Level', ['yearlevel_edit.php']],
    ['subjects.php',  '📘', 'Subjects', ['subject_edit.php']],
    ['instructors.php','🧑‍🏫', 'Instructor', ['instructor_edit.php']],
];

if (isAdmin()) {
    $navGroups[] = ['users.php',     '👤', 'Users', ['user_edit.php']];
    $navGroups[] = ['usertypes.php', '🛡️', 'User Type', ['usertype_edit.php']];
}

// Show only the pages this user type is allowed to open
$navGroups = array_values(array_filter($navGroups, fn($n) => canAccessPage($n[0])));
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($pageTitle ?? 'Student Management System') ?></title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="layout">

  <aside class="sidebar">
    <div class="sidebar-brand">
      <span class="brand-badge">🏛️</span>
      <div>
        <div class="brand-text">MSTIP Academic</div>
        <div class="brand-sub">Student Management System</div>
      </div>
    </div>
    <nav class="sidebar-nav">
      <?php foreach ($navGroups as $nav):
          [$href, $icon, $label] = $nav;
          $related = $nav[3] ?? [];
          $isActive = $currentPage === $href || in_array($currentPage, $related, true);
      ?>
        <a href="<?= $href ?>" class="<?= $isActive ? 'active' : '' ?>">
          <span class="icon"><?= $icon ?></span> <?= htmlspecialchars($label) ?>
        </a>
      <?php endforeach; ?>
      <a href="logout.php" class="logout-link" onclick="return confirm('Log out of the system?');">
        <span class="icon">🚪</span> Logout
      </a>
    </nav>
    <?php if (!empty($_SESSION['usertype_name'])): ?>
      <div class="sidebar-foot"><?= userPhotoHtml($_SESSION['username'] ?? '', 'thumb thumb-sm') ?> <?= htmlspecialchars($_SESSION['usertype_name']) ?></div>
    <?php endif; ?>
  </aside>

  <div class="main">
    <header class="topbar">
      <button class="menu-toggle" id="menuToggle">☰</button>
      <h1 class="page-title"><?= htmlspecialchars($pageTitle ?? '') ?></h1>
      <div class="topbar-user">
        <?= userPhotoHtml($_SESSION['username'] ?? '', 'thumb thumb-sm') ?>
        <span class="user-fullname"><?= htmlspecialchars($displayName) ?></span>
        <a href="logout.php" class="btn-logout" onclick="return confirm('Log out of the system?');">Logout</a>
      </div>
    </header>
    <main class="content">
