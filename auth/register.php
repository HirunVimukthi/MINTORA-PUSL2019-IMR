<?php
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}
require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/header.php';

$errorMessage = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fullName = trim($_POST['full_name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $phone = trim($_POST['phone'] ?? '');
    $password = $_POST['password'] ?? '';
    $role = $_POST['role'] ?? '';
    $allowedRoles = ['Freelancer', 'Client', 'Admin', 'Manager'];

    if ($fullName === '' || $email === '' || $password === '' || !in_array($role, $allowedRoles, true)) {
        $errorMessage = 'Please complete all required fields and select a valid role.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errorMessage = 'Please enter a valid email address.';
    } elseif (strlen($password) < 8) {
        $errorMessage = 'Password must be at least 8 characters long.';
    } elseif ($pdo === null) {
        $errorMessage = 'Database connection is unavailable.';
    } else {
        try {
            $roleFieldsValid = true;
            $bio = trim($_POST['bio'] ?? '');
            $hourlyRate = trim($_POST['hourly_rate'] ?? '');
            $experienceYears = trim($_POST['experience_years'] ?? '');
            $clientType = $_POST['client_type'] ?? '';
            $companyName = trim($_POST['company_name'] ?? '');
            $industry = trim($_POST['industry'] ?? '');
            $country = trim($_POST['country'] ?? '');
            $department = trim($_POST['department'] ?? '');
            $division = trim($_POST['division'] ?? '');
            $reportScope = trim($_POST['report_scope'] ?? '');

            if ($role === 'Freelancer') {
                $roleFieldsValid = $hourlyRate !== '' && is_numeric($hourlyRate)
                    && $experienceYears !== '' && ctype_digit($experienceYears);
            } elseif ($role === 'Client') {
                $roleFieldsValid = in_array($clientType, ['Individual', 'Organization'], true);
            } elseif ($role === 'Admin') {
                $roleFieldsValid = $department !== '';
            } elseif ($role === 'Manager') {
                $roleFieldsValid = $division !== '';
            }

            if (!$roleFieldsValid) {
                throw new InvalidArgumentException('Please complete the fields required for the selected role.');
            }

            $passwordHash = password_hash($password, PASSWORD_DEFAULT);

            $pdo->beginTransaction();
            $statement = $pdo->prepare(
                'INSERT INTO `USER` (`Full_Name`, `Email`, `Password_Hash`, `Phone`, `User_Role`, `Account_Status`)
                 VALUES (:full_name, :email, :password_hash, :phone, :role, :status)'
            );
            $statement->execute([
                'full_name' => $fullName,
                'email' => $email,
                'password_hash' => $passwordHash,
                'phone' => $phone !== '' ? $phone : null,
                'role' => $role,
                'status' => 'Active',
            ]);
            $userId = (int) $pdo->lastInsertId();

            if ($role === 'Freelancer') {
                $statement = $pdo->prepare(
                    'INSERT INTO `FREELANCER`
                     (`Freelancer_ID`, `Bio`, `Hourly_Rate`, `Experience_Years`)
                     VALUES (:id, :bio, :hourly_rate, :experience_years)'
                );
                $statement->execute([
                    'id' => $userId,
                    'bio' => $bio !== '' ? $bio : null,
                    'hourly_rate' => (float) $hourlyRate,
                    'experience_years' => (int) $experienceYears,
                ]);
            } elseif ($role === 'Client') {
                $statement = $pdo->prepare(
                    'INSERT INTO `CLIENT`
                     (`Client_ID`, `Client_Type`, `Company_Name`, `Industry`, `Country`)
                     VALUES (:id, :client_type, :company_name, :industry, :country)'
                );
                $statement->execute([
                    'id' => $userId,
                    'client_type' => $clientType,
                    'company_name' => $companyName !== '' ? $companyName : null,
                    'industry' => $industry !== '' ? $industry : null,
                    'country' => $country !== '' ? $country : null,
                ]);
            } elseif ($role === 'Admin') {
                $statement = $pdo->prepare(
                    'INSERT INTO `ADMIN_STAFF` (`Admin_ID`, `Department`, `Access_Level`)
                     VALUES (:id, :department, :access_level)'
                );
                $statement->execute([
                    'id' => $userId,
                    'department' => $department,
                    'access_level' => 'Standard',
                ]);
            } else {
                $statement = $pdo->prepare(
                    'INSERT INTO `MANAGER` (`Manager_ID`, `Division`, `Report_Scope`)
                     VALUES (:id, :division, :report_scope)'
                );
                $statement->execute([
                    'id' => $userId,
                    'division' => $division,
                    'report_scope' => $reportScope !== '' ? $reportScope : null,
                ]);
            }

            $pdo->commit();
            $_SESSION['flash_message'] = 'Registration successful. Please log in.';
            $_SESSION['flash_type'] = 'success';
            header('Location: /mintora/auth/login.php');
            exit;
        } catch (InvalidArgumentException $exception) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $errorMessage = $exception->getMessage();
        } catch (PDOException $exception) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $errorMessage = $exception->errorInfo[1] === 1062
                ? 'An account with that email address already exists.'
                : 'Registration failed. Please try again.';
        }
    }
}
?>

<div class="row justify-content-center">
    <div class="col-lg-8 col-xl-7">
        <div class="card border-0 shadow-lg">
            <div class="card-body p-4 p-md-5">
                <h1 class="h3 mb-4">Create your MINTORA account</h1>
                <?php if ($errorMessage !== ''): ?>
                    <div class="alert alert-danger" role="alert"><?= htmlspecialchars($errorMessage) ?></div>
                <?php endif; ?>
                <form method="post" action="/mintora/auth/register.php" novalidate>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="full_name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="full_name" name="full_name" required
                                   value="<?= htmlspecialchars($_POST['full_name'] ?? '') ?>">
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required
                                   value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   value="<?= htmlspecialchars($_POST['phone'] ?? '') ?>">
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" minlength="8" required>
                        </div>
                        <div class="col-12">
                            <label for="role" class="form-label">Role</label>
                            <select class="form-select" id="role" name="role" required>
                                <option value="">Select a role</option>
                                <?php foreach (['Freelancer', 'Client', 'Admin', 'Manager'] as $roleOption): ?>
                                    <option value="<?= $roleOption ?>" <?= (($_POST['role'] ?? '') === $roleOption) ? 'selected' : '' ?>>
                                        <?= $roleOption ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="col-12 role-fields" data-role="Freelancer" hidden>
                            <div class="border rounded p-3">
                                <h2 class="h6">Freelancer details</h2>
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label for="bio" class="form-label">Bio</label>
                                        <textarea class="form-control" id="bio" name="bio" rows="3"><?= htmlspecialchars($_POST['bio'] ?? '') ?></textarea>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="hourly_rate" class="form-label">Hourly Rate</label>
                                        <input type="number" class="form-control" id="hourly_rate" name="hourly_rate" min="0" step="0.01"
                                               value="<?= htmlspecialchars($_POST['hourly_rate'] ?? '') ?>">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="experience_years" class="form-label">Experience Years</label>
                                        <input type="number" class="form-control" id="experience_years" name="experience_years" min="0" step="1"
                                               value="<?= htmlspecialchars($_POST['experience_years'] ?? '') ?>">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 role-fields" data-role="Client" hidden>
                            <div class="border rounded p-3">
                                <h2 class="h6">Client details</h2>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="client_type" class="form-label">Client Type</label>
                                        <select class="form-select" id="client_type" name="client_type">
                                            <option value="">Select type</option>
                                            <?php foreach (['Individual', 'Organization'] as $clientTypeOption): ?>
                                                <option value="<?= $clientTypeOption ?>" <?= (($_POST['client_type'] ?? '') === $clientTypeOption) ? 'selected' : '' ?>>
                                                    <?= $clientTypeOption ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="company_name" class="form-label">Company Name</label>
                                        <input type="text" class="form-control" id="company_name" name="company_name"
                                               value="<?= htmlspecialchars($_POST['company_name'] ?? '') ?>">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="industry" class="form-label">Industry</label>
                                        <input type="text" class="form-control" id="industry" name="industry"
                                               value="<?= htmlspecialchars($_POST['industry'] ?? '') ?>">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="country" class="form-label">Country</label>
                                        <input type="text" class="form-control" id="country" name="country"
                                               value="<?= htmlspecialchars($_POST['country'] ?? '') ?>">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 role-fields" data-role="Admin" hidden>
                            <div class="border rounded p-3">
                                <label for="department" class="form-label">Department</label>
                                <input type="text" class="form-control" id="department" name="department"
                                       value="<?= htmlspecialchars($_POST['department'] ?? '') ?>">
                            </div>
                        </div>

                        <div class="col-12 role-fields" data-role="Manager" hidden>
                            <div class="border rounded p-3">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="division" class="form-label">Division</label>
                                        <input type="text" class="form-control" id="division" name="division"
                                               value="<?= htmlspecialchars($_POST['division'] ?? '') ?>">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="report_scope" class="form-label">Report Scope</label>
                                        <input type="text" class="form-control" id="report_scope" name="report_scope"
                                               value="<?= htmlspecialchars($_POST['report_scope'] ?? '') ?>">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-primary px-4">Create Account</button>
                            <a href="/mintora/auth/login.php" class="btn btn-link">Already have an account?</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    const roleSelect = document.getElementById('role');
    const roleFields = document.querySelectorAll('.role-fields');

    function toggleRoleFields() {
        roleFields.forEach((section) => {
            const isSelected = section.dataset.role === roleSelect.value;
            section.hidden = !isSelected;
        });
    }

    roleSelect.addEventListener('change', toggleRoleFields);
    toggleRoleFields();
</script>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
