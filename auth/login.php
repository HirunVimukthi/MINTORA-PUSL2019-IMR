<?php
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/header.php';

$errorMessage = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($email === '' || $password === '') {
        $errorMessage = 'Email and password are required.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errorMessage = 'Please enter a valid email address.';
    } elseif ($pdo === null) {
        $errorMessage = 'Database connection is unavailable.';
    } else {
        $statement = $pdo->prepare(
            'SELECT `User_ID`, `Full_Name`, `Email`, `Password_Hash`, `User_Role`, `Account_Status`
             FROM `USER`
             WHERE `Email` = :email
             LIMIT 1'
        );
        $statement->execute(['email' => $email]);
        $user = $statement->fetch();

        if (!$user || !password_verify($password, $user['Password_Hash'])) {
            $errorMessage = 'Invalid email or password.';
        } elseif ($user['Account_Status'] !== 'Active') {
            $errorMessage = 'Your account is not active.';
        } else {
            session_regenerate_id(true);
            $_SESSION['user_id'] = (int) $user['User_ID'];
            $_SESSION['full_name'] = $user['Full_Name'];
            $_SESSION['user_role'] = $user['User_Role'];
            header('Location: /mintora/index.php');
            exit;
        }
    }
}
?>

<div class="row justify-content-center">
    <div class="col-md-7 col-lg-5">
        <div class="card border-0 shadow-lg">
            <div class="card-body p-4 p-md-5">
                <h1 class="h3 mb-4">Sign in to MINTORA</h1>
                <?php if ($errorMessage !== ''): ?>
                    <div class="alert alert-danger" role="alert"><?= htmlspecialchars($errorMessage) ?></div>
                <?php endif; ?>
                <form method="post" action="/mintora/auth/login.php">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required
                               value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
                    </div>
                    <div class="mb-4">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
                <p class="text-center mt-3 mb-0">
                    New to MINTORA?
                    <a href="/mintora/auth/register.php">Create an account</a>
                </p>
            </div>
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
