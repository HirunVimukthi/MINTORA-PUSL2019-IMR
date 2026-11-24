<?php
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

$loggedIn = isset($_SESSION['user_id']);
$fullName = $loggedIn ? ($_SESSION['full_name'] ?? 'User') : '';
$userRole = $loggedIn ? ($_SESSION['user_role'] ?? '') : '';
$currentPage = $_SERVER['PHP_SELF'] ?? '';

// Role-specific navigation links are kept in one place for consistent rendering.
$roleLinks = [
    'Freelancer' => [
        'Dashboard' => '/mintora/freelancer/dashboard.php',
        'Browse Projects' => '/mintora/freelancer/browse_projects.php',
        'My Proposals' => '/mintora/freelancer/my_proposals.php',
    ],
    'Client' => [
        'Dashboard' => '/mintora/client/dashboard.php',
        'Post Project' => '/mintora/client/post_project.php',
        'Manage Proposals' => '/mintora/client/manage_proposals.php',
    ],
    'Admin' => [
        'Dashboard' => '/mintora/admin/dashboard.php',
        'Manage Users' => '/mintora/admin/manage_users.php',
        'Disputes' => '/mintora/admin/disputes.php',
    ],
    'Manager' => [
        'Dashboard' => '/mintora/manager/dashboard.php',
        'Analytics & Reports' => '/mintora/manager/reports.php',
    ],
];

$visibleLinks = $loggedIn ? ($roleLinks[$userRole] ?? []) : [];
$isActive = static function (string $path) use ($currentPage): bool {
    return str_replace('\\', '/', $currentPage) === str_replace('\\', '/', $path)
        || substr(str_replace('\\', '/', $currentPage), -strlen($path)) === $path;
};
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MINTORA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f4f7fb; }
        .navbar-mintora { background: linear-gradient(135deg, #111827, #1f2937); }
        .brand-mark { width: 36px; height: 36px; }
        .hero-gradient {
            background: linear-gradient(135deg, #111827 0%, #312e81 55%, #4338ca 100%);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-mintora shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="/mintora/index.php">
            <span class="brand-mark rounded-circle bg-primary d-inline-flex align-items-center justify-content-center">M</span>
            MINTORA
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link<?= $isActive('/mintora/index.php') ? ' active' : '' ?>"
                       <?= $isActive('/mintora/index.php') ? 'aria-current="page"' : '' ?>
                       href="/mintora/index.php">Home</a>
                </li>
                <?php foreach ($visibleLinks as $label => $path): ?>
                    <li class="nav-item">
                        <a class="nav-link<?= $isActive($path) ? ' active' : '' ?>"
                           <?= $isActive($path) ? 'aria-current="page"' : '' ?>
                           href="<?= htmlspecialchars($path) ?>"><?= htmlspecialchars($label) ?></a>
                    </li>
                <?php endforeach; ?>
            </ul>
            <div class="ms-auto d-flex align-items-center gap-2 mt-3 mt-lg-0">
                <?php if ($loggedIn): ?>
                    <span class="text-white fw-semibold"><?= htmlspecialchars($fullName) ?></span>
                    <span class="badge text-bg-primary"><?= htmlspecialchars($userRole) ?></span>
                    <a class="btn btn-outline-light btn-sm" href="/mintora/auth/logout.php">Logout</a>
                <?php else: ?>
                    <a class="btn btn-outline-light btn-sm" href="/mintora/auth/login.php">Login</a>
                    <a class="btn btn-primary btn-sm" href="/mintora/auth/register.php">Register</a>
                <?php endif; ?>
            </div>
        </div>
    </div>
</nav>

<main class="container py-4">
    <?php if (!empty($_SESSION['flash_message'])): ?>
        <?php
        $flashType = $_SESSION['flash_type'] ?? 'info';
        $allowedTypes = ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'];
        if (!in_array($flashType, $allowedTypes, true)) {
            $flashType = 'info';
        }
        ?>
        <div class="alert alert-<?= htmlspecialchars($flashType) ?> alert-dismissible fade show" role="alert">
            <?= htmlspecialchars($_SESSION['flash_message']) ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <?php
        unset($_SESSION['flash_message'], $_SESSION['flash_type']);
        ?>
    <?php endif; ?>
