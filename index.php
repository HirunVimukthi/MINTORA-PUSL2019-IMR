<?php
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/header.php';

$dbConnected = $pdo !== null;
if ($dbConnected) {
    try {
        $pdo->query('SELECT 1');
    } catch (PDOException $exception) {
        $dbConnected = false;
    }
}

$domains = [
    'Machine Learning',
    'Deep Learning',
    'Natural Language Processing',
    'Computer Vision',
    'Generative AI',
    'Data Analytics',
];
?>

<section class="hero-gradient text-white rounded-4 shadow-lg p-4 p-md-5 mb-4">
    <div class="row align-items-center g-4">
        <div class="col-lg-8">
            <span class="badge text-bg-light text-primary mb-3">AI Projects &amp; Services Marketplace</span>
            <h1 class="display-5 fw-bold mb-3">Build the future with MINTORA</h1>
            <p class="lead mb-4">
                Connect with skilled AI professionals or discover clients, proposals, and services across the
                complete artificial intelligence ecosystem.
            </p>
            <?php if (!isset($_SESSION['user_id'])): ?>
                <a href="/mintora/auth/register.php" class="btn btn-light btn-lg me-2">Join MINTORA</a>
                <a href="/mintora/auth/login.php" class="btn btn-outline-light btn-lg">Sign In</a>
            <?php endif; ?>
        </div>
        <div class="col-lg-4">
            <div class="bg-white bg-opacity-10 border border-light border-opacity-25 rounded-4 p-4">
                <h2 class="h5">Six AI domains</h2>
                <div class="d-flex flex-wrap gap-2 mt-3">
                    <?php foreach ($domains as $domain): ?>
                        <span class="badge rounded-pill text-bg-light"><?= htmlspecialchars($domain) ?></span>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>
    </div>
</section>

<?php if (isset($_SESSION['user_id'])): ?>
    <section class="card border-0 shadow-sm mb-4">
        <div class="card-body d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 p-4">
            <div>
                <h2 class="h4 mb-1">Welcome, <?= htmlspecialchars($_SESSION['full_name']) ?></h2>
                <p class="text-secondary mb-0">Signed in as <strong><?= htmlspecialchars($_SESSION['user_role']) ?></strong></p>
            </div>
            <?php if ($dbConnected): ?>
                <span class="badge text-bg-success px-3 py-2">Database Connected</span>
            <?php else: ?>
                <span class="badge text-bg-danger px-3 py-2">Database Unavailable</span>
            <?php endif; ?>
        </div>
    </section>
<?php endif; ?>

<section class="row g-3">
    <?php foreach ($domains as $domain): ?>
        <div class="col-sm-6 col-lg-4">
            <article class="card h-100 border-0 shadow-sm">
                <div class="card-body">
                    <h2 class="h5"><?= htmlspecialchars($domain) ?></h2>
                    <p class="text-secondary mb-0">Find expert talent and high-quality AI projects in this domain.</p>
                </div>
            </article>
        </div>
    <?php endforeach; ?>
</section>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
