# Student Management System (PHP)

A session-based Enrollment/Student Management System with login, dashboard,
and full add/search/edit/delete management for every table in your
`student_db` database.

## What's included

**Auth**
- `login.php` — login form, checks against `tbl_users`, starts the session
- `register.php` — public sign-up form (linked from the login page). New accounts are always created as the **Student** user type; the type can't be chosen on the form, so nobody can self-register as Admin. Admins can change a user's type later in Users.
- `logout.php` — destroys the session, redirects to login

**Dashboard**
- `dashboard.php` — counts + recent students (Users count shown to Admins only)

**Students**
- `students.php` — searchable list, with delete
- `student_add.php` / `student_edit.php` — add/edit forms
- `student_delete.php` — handles the delete POST

**Lookup tables** — each has one combined Add+Search+List page, an edit page,
and a delete handler:
- `courses.php` / `course_edit.php` / `course_delete.php` → `tbl_course`
- `sections.php` / `section_edit.php` / `section_delete.php` → `tbl_section`
- `terms.php` / `term_edit.php` / `term_delete.php` → `tbl_term`
- `yearlevels.php` / `yearlevel_edit.php` / `yearlevel_delete.php` → `tbl_yearlevel`
- `schoolyears.php` / `schoolyear_edit.php` / `schoolyear_delete.php` → `tbl_schoolyear`
- `subjects.php` / `subject_edit.php` / `subject_delete.php` → `tbl_subject`

**Users & User Types** *(Admin usertype only — see Access control below)*
- `users.php` / `user_edit.php` / `user_delete.php` → `tbl_users`
- `usertypes.php` / `usertype_edit.php` / `usertype_delete.php` → `tbl_usertype`

**Shared**
- `config.php` — DB connection settings (edit this first)
- `includes/` — shared header/footer/sidebar/auth-check/admin-check/form partials
- `assets/css/style.css` — all styling
- `sql/student_db.sql` — your original dump **plus**:
  - a new `tbl_student` table (student records) with sample rows, since the
    uploaded dump only had lookup tables and no actual student data table
  - a unique constraint on `tbl_users.USERNAME`
  - default `tbl_usertype_id` values for the two accounts that shipped
    with `NULL` (`ADMIN` → Admin, `Tammy17` → Student)

## v4 changes

- **Roles / page access** — `includes/permissions.php` is the single place that says who can open what:
  | User type  | Pages |
  |------------|-------|
  | Admin      | everything |
  | Registrar  | Subjects, Term, Instructor, School Year |
  | Dean       | Subjects, Section, Instructor, Year Level |
  | Instructor | Subjects, Section |
  | Student    | Subjects (view-only, search disabled) |

  Pages not listed there are admin-only. Everyone lands on the Dashboard; non-admins see only links to their pages.
- **Sign-up page** now has a *User Type* dropdown so the 3 accounts per user type can be created from `register.php`.
  Controlled by `ALLOW_ROLE_SELECTION_ON_SIGNUP` in `config.php` — **set it to `false` when you're done**, otherwise anyone can sign up as Admin.
- **Instructor** page (`instructors.php`, `instructor_edit.php`, `instructor_delete.php`) with table `tbl_instructors`
  (ID, SALUTATION, FIRSTNAME, MIDDLENAME, LASTNAME + PHOTO). Photos are saved in `uploads/instructors/`.
- User types `Program Head` / `Professor` were renamed to `Dean` / `Instructor`.
  Existing database? Run `sql/migration_v4.sql`. New database? Just import `sql/student_db.sql`.

## v5 changes - user photos

- Every sign-up / Add User form now has a **Photo** field (optional; JPG, JPEG, PNG or GIF, max 2 MB).
- The photo is saved to `images/users/<username>.JPG` (e.g. `images/users/Tammy17.JPG`). Nothing is added to the database.
- The signed-in user's photo appears in the top bar, the sidebar footer and the dashboard welcome card; the Users list shows everyone's photo.
- Edit User can replace the photo; renaming a user renames the file; deleting a user deletes the file.
- Helper functions live in `includes/user_photo.php`. If a user has no photo, a 👤 placeholder is shown.

## Access control

Every page requires login. On top of that, **Users** and **User Type**
management are restricted to accounts whose `tbl_usertype_id` is `1`
(`Admin`, per `tbl_usertype`) — `includes/admin_check.php` enforces this and
redirects anyone else to the dashboard with a permission message. Those two
links are also hidden from the sidebar for non-admin accounts.

## Setup (XAMPP / similar)

1. Copy this whole folder into `htdocs/` (or your web root).
2. Create the database and import the schema:
   ```sql
   CREATE DATABASE student_db;
   ```
   Then import `sql/student_db.sql` via phpMyAdmin or:
   ```
   mysql -u root -p student_db < sql/student_db.sql
   ```
3. Open `config.php` and set your MySQL username/password if not the
   default XAMPP `root` / (blank).
4. The `tbl_users` rows that came with the original dump (`Tammy17`, `ADMIN`) have unknown
   passwords. Ignore them and create your own accounts on `register.php`
   (pick the user type in the dropdown).
5. Go to `login.php` and log in.

## How the session/login requirement works

- `config.php` calls `session_start()` on every page.
- Every protected page (`dashboard.php`, `students.php`, `student_add.php`,
  `student_edit.php`, `student_delete.php`) includes `includes/auth_check.php`
  right after `config.php`. That file checks `$_SESSION['user_id']`; if it's
  not set, it redirects to `login.php` and stops execution (`exit`).
- On successful login, `login.php` sets `$_SESSION['user_id']`,
  `$_SESSION['username']`, and `$_SESSION['fullname']`.
- `includes/header.php` (used by every protected page) reads
  `$_SESSION['fullname']` (falling back to `username`) and displays it in
  the top bar on every page.
- `logout.php` clears `$_SESSION`, deletes the session cookie, and calls
  `session_destroy()`, then redirects to `login.php`.

## Notes / things you may want to change

- Passwords are checked with `password_verify()` against bcrypt hashes in
  `tbl_users.PASSWORD` — never store plaintext passwords.
- All queries use PDO prepared statements to avoid SQL injection.
- `tbl_student.STUDENT_NO` and `tbl_users.USERNAME` are unique; add/edit
  forms check for duplicates before saving.
- `tbl_subject.COURSE` / `YEARLEVEL` / `TERM` are stored as free text (that's
  how the original dump models them, matching the wording in
  `tbl_course.DESCRIPTION`, `tbl_yearlevel.DESCRIPTION`, and
  `tbl_term.DESCRIPTION`) — the Subject form's dropdowns pull from those
  three tables so the wording always matches.
- Deleting a Course / Section / Year Level / School Year that students are
  currently assigned to unlinks it from those students (`ON DELETE SET
  NULL`) rather than blocking the delete.
- Deleting a User Type that's still assigned to a user is blocked with an
  error message.
- You can't delete your own account while logged in as it (self-delete is
  blocked in `user_delete.php`).
- The CSS is a single flat stylesheet (`assets/css/style.css`) — no
  frameworks required.
