# BK MART Premium Multi-Hotel Ordering

## Files
- `index.html` — customer website
- `admin.html` — admin dashboard
- `api/index.php` — PHP API, admin session and atomic token generation
- `api/config.sample.php` — configuration template (copy to `config.php`)
- `database.sql` — MySQL schema

## cPanel setup
1. Create a MySQL database and database user in cPanel. Assign the user **ALL PRIVILEGES** to that database.
2. Open phpMyAdmin, select the new database, import `database.sql`.
3. Upload `index.html`, `admin.html`, and the `api` folder to the same public website folder (for example `public_html/`).
4. In `api/`, copy `config.sample.php` to `config.php`.
5. Edit `api/config.php`: enter DB host/name/user/password and replace `ADMIN_PASSWORD` with a long unique password. Do not upload `config.php` to a public GitHub repository.
6. Open `https://YOUR-DOMAIN/admin.html`, sign in, add hotels, menu items and price options.
7. Open the website. Each hotel appears as a top category. Select it to see only that hotel's items.

## Token behaviour
The API creates a token on the server inside a MySQL transaction while locking the daily counter row. Format: `BK-YYMMDD-001`. It increments independently for each date and prevents two simultaneous orders from receiving the same daily number. Tokens reset to 001 on the next date. Orders are stored in MySQL and visible in Admin > Orders & Tokens.

## Important notes
- This build uses MySQL/PHP, not GitHub JSON, for orders and token numbering.
- Menu photos are entered as image URLs. Use HTTPS image URLs.
- UPI payment currently records the selected payment method only. It does not verify a payment. Add a verified payment gateway before treating UPI orders as paid.
- Enable HTTPS on the domain. Keep `api/config.php` private and use a strong admin password.
- If your hosting does not have PHP PDO MySQL enabled, ask hosting support to enable `pdo_mysql`.
