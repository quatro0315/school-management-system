# Render deployment — Student Management System

## What is included
- PHP 8.3 + Apache Dockerfile (note capital **D**)
- PDO MySQL TLS connection with Aiven CA validation
- GD extension for photo uploads; session cookie configuration; UTF-8 without BOM
- SQL import adapted for Aiven `sql_require_primary_key=ON`: `sql/student_db_aiven.sql`
- Existing pages, user management, roles, styling and original SQL retained

## Upload to GitHub
Extract the ZIP and upload the **contents** directly into your repository root. The root must show `Dockerfile`, `config.php`, `login.php`, `index.php`, and folders such as `includes/` and `assets/`.

## Import MySQL (once, into an EMPTY database)
Using a MySQL client connected with TLS to Aiven, choose `defaultdb` and import `sql/student_db_aiven.sql`. Do NOT import over populated existing tables. If already imported and working, reuse your existing database.

## Render Web Service
- Runtime/Language: Docker
- Branch: main
- Root directory: blank (assuming files are in root)
- Dockerfile path: `./Dockerfile`
- Environment variables: `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` (usually `defaultdb`), `DB_SSL_CA_PATH=/etc/secrets/ca.pem`
- Secret File: `ca.pem` containing the full CA certificate downloaded from Aiven (not in GitHub)
- The Dockerfile creates group 1000 and adds `www-data` so Apache PHP can read the Render Secret File.

## Login
The uploaded database contains bcrypt password hashes: no default plaintext password is asserted. Use an existing account's known password, or reset hashes through PHP `password_hash` in the test DB. The application's login form asks for **username**, not email.

## Security and deployment notes
- `ALLOW_ROLE_SELECTION_ON_SIGNUP` is false: new registrations cannot choose Admin role.
- Static files in `images/users/` and `uploads/instructors/` are stored on Render's ephemeral filesystem: **new uploads will disappear on restart or redeploy**. Configure external storage or persistent disk for permanent uploads.
- Test the database connection, login, permissions, CRUD, and uploads after deployment; no live Render/Aiven deployment was performed.
- If a Render build fails due to a stale Dockerfile path, clear the root directory or point it at the folder containing Dockerfile.
