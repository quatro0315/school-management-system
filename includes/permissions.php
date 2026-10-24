<?php
/**
 * Role-based page access.
 *
 * Roles are matched by the user type NAME stored in tbl_usertype
 * (saved in $_SESSION['usertype_name'] at login), so renumbering IDs won't break anything.
 *
 *   Admin      = every page
 *   Registrar  = Subjects, Term, Instructor, School Year
 *   Dean       = Subjects, Section, Instructor, Year Level
 *   Instructor = Subjects, Section
 *   Student    = Subjects (read-only, no search)
 *
 * Any page that is NOT listed in $PAGE_MODULES below is admin-only (fail closed).
 */

// page file  => module
$PAGE_MODULES = [
    'subjects.php'       => 'subjects',
    'subject_edit.php'   => 'subjects',
    'subject_delete.php' => 'subjects',

    'terms.php'          => 'terms',
    'term_edit.php'      => 'terms',
    'term_delete.php'    => 'terms',

    'instructors.php'       => 'instructors',
    'instructor_edit.php'   => 'instructors',
    'instructor_delete.php' => 'instructors',

    'schoolyears.php'       => 'schoolyears',
    'schoolyear_edit.php'   => 'schoolyears',
    'schoolyear_delete.php' => 'schoolyears',

    'sections.php'       => 'sections',
    'section_edit.php'   => 'sections',
    'section_delete.php' => 'sections',

    'yearlevels.php'       => 'yearlevels',
    'yearlevel_edit.php'   => 'yearlevels',
    'yearlevel_delete.php' => 'yearlevels',
];

// Pages every logged-in user may open
$OPEN_PAGES = ['dashboard.php', 'logout.php'];

// role (lowercase) => modules
$ROLE_MODULES = [
    'registrar'  => ['subjects', 'terms', 'instructors', 'schoolyears'],
    'dean'       => ['subjects', 'sections', 'instructors', 'yearlevels'],
    'instructor' => ['subjects', 'sections'],
    'student'    => ['subjects'],
];

function currentRole(): string
{
    return strtolower(trim($_SESSION['usertype_name'] ?? ''));
}

function isAdmin(): bool
{
    return currentRole() === 'admin';
}

/** Students may look at subjects but never change them. */
function isReadOnlyRole(): bool
{
    return currentRole() === 'student';
}

/** Search is switched off for students. */
function canSearch(): bool
{
    return currentRole() !== 'student';
}

function canAccessPage(string $file): bool
{
    global $PAGE_MODULES, $OPEN_PAGES, $ROLE_MODULES;

    $file = basename($file);
    if (in_array($file, $OPEN_PAGES, true)) return true;
    if (isAdmin()) return true;

    $module = $PAGE_MODULES[$file] ?? null;   // unlisted page => admin only
    if ($module === null) return false;

    return in_array($module, $ROLE_MODULES[currentRole()] ?? [], true);
}

function denyAccess(string $message = 'You do not have permission to access that page.'): void
{
    $_SESSION['flash'] = ['type' => 'error', 'message' => $message];
    header("Location: dashboard.php");
    exit;
}

/** Call at the top of any page/handler that changes data. */
function blockIfReadOnly(string $redirect): void
{
    if (isReadOnlyRole()) {
        $_SESSION['flash'] = ['type' => 'error', 'message' => 'Your account has view-only access.'];
        header("Location: $redirect");
        exit;
    }
}
