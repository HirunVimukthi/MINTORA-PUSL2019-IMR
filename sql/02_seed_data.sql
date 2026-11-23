USE mintora_db;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE DISPUTE;
TRUNCATE TABLE REVIEW;
TRUNCATE TABLE PAYMENT;
TRUNCATE TABLE PROJECT_ASSIGNMENT;
TRUNCATE TABLE PROPOSAL;
TRUNCATE TABLE PROJECT_REQUIREMENT;
TRUNCATE TABLE PROJECT;
TRUNCATE TABLE AI_SERVICE;
TRUNCATE TABLE FREELANCER_SKILL;
TRUNCATE TABLE AI_SKILL;
TRUNCATE TABLE MANAGER;
TRUNCATE TABLE ADMIN_STAFF;
TRUNCATE TABLE CLIENT;
TRUNCATE TABLE FREELANCER;
TRUNCATE TABLE `USER`;
SET FOREIGN_KEY_CHECKS = 1;



INSERT INTO `USER`
    (`User_ID`, `Full_Name`, `Email`, `Password_Hash`, `Phone`, `User_Role`, `Account_Status`, `Created_At`)
VALUES
    (1,  'Kasun Perera',        'kasun.perera@example.lk',        '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 234 5678', 'Freelancer', 'Active',     '2025-01-08 09:15:00'),
    (2,  'Nadeesha Fernando',    'nadeesha.fernando@example.lk',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 77 812 3456', 'Freelancer', 'Active',     '2025-01-11 10:30:00'),
    (3,  'Dhanushka Silva',     'dhanushka.silva@example.lk',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 76 455 7821', 'Freelancer', 'Active',     '2025-01-14 14:20:00'),
    (4,  'Maya Patel',           'maya.patel@example.com',          '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44 7700 900124', 'Freelancer', 'Active',     '2025-01-18 08:45:00'),
    (5,  'Amal Jayasinghe',     'amal.jayasinghe@example.lk',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 903 4451', 'Freelancer', 'Active',     '2025-01-21 12:10:00'),
    (6,  'Ruwan Wickramasinghe','ruwan.wickramasinghe@example.lk','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 78 221 6390', 'Freelancer', 'Active',     '2025-01-24 16:05:00'),
    (7,  'Olivia Thompson',     'olivia.thompson@example.com',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1 415 555 0182', 'Freelancer', 'Active',     '2025-02-02 09:40:00'),
    (8,  'Tharindu Bandara',    'tharindu.bandara@example.lk',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 75 660 1824', 'Freelancer', 'Active',     '2025-02-05 11:25:00'),
    (9,  'Sophie Martin',       'sophie.martin@example.fr',       '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+33 6 12 34 56 78','Freelancer','Active',     '2025-02-09 13:35:00'),
    (10, 'Chathuri Samarasinghe','chathuri.samarasinghe@example.lk','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 70 381 9927', 'Freelancer', 'Active',     '2025-02-12 15:50:00'),
    (11, 'Ethan Williams',      'ethan.williams@example.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+61 412 555 031', 'Freelancer', 'Active',     '2025-02-16 10:05:00'),
    (12, 'Pramod Gunawardena',  'pramod.gunawardena@example.lk',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 72 144 2869', 'Freelancer', 'Suspended',  '2025-02-19 17:15:00'),

    (13, 'Anuradha Weerasinghe', 'anuradha.weerasinghe@example.lk', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 510 3342', 'Client', 'Active', '2025-03-03 08:20:00'),
    (14, 'David Chen',           'david.chen@example.sg',           '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+65 8123 4567',   'Client', 'Active', '2025-03-06 09:25:00'),
    (15, 'Sanduni Rathnayake',   'sanduni.rathnayake@example.lk',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 77 645 2198', 'Client', 'Active', '2025-03-10 11:40:00'),
    (16, 'Michael Brown',        'michael.brown@example.co.uk',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44 20 7946 0958','Client', 'Active', '2025-03-13 13:55:00'),
    (17, 'Harini Senanayake',    'harini.senanayake@example.lk',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 76 118 7623', 'Client', 'Active', '2025-03-17 10:15:00'),
    (18, 'Emma Wilson',          'emma.wilson@example.com.au',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+61 3 5550 1276','Client', 'Active', '2025-03-20 14:45:00'),
    (19, 'Nuwan Rajapaksa',      'nuwan.rajapaksa@example.lk',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 822 4509', 'Client', 'Active', '2025-03-24 09:35:00'),
    (20, 'Priya Nair',           'priya.nair@example.com',          '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+971 50 555 1048','Client', 'Active', '2025-03-28 16:20:00'),
    (21, 'Lukas Schneider',      'lukas.schneider@example.de',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 30 5557 2210','Client', 'Active', '2025-04-01 08:50:00'),
    (22, 'Chamodi Dias',         'chamodi.dias@example.lk',         '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 75 270 8831', 'Client', 'Active', '2025-04-05 12:05:00'),
    (23, 'James Anderson',       'james.anderson@example.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1 212 555 0146','Client', 'Active', '2025-04-08 15:25:00'),
    (24, 'Dilini Karunaratne',   'dilini.karunaratne@example.lk',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 78 934 6172', 'Client', 'Pending','2025-04-12 10:35:00'),

    (25, 'Ishan Madushanka',     'ishan.madushanka@mintora.lk',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 300 1001', 'Admin', 'Active', '2025-01-02 08:00:00'),
    (26, 'Malini Jayawardena',   'malini.jayawardena@mintora.lk',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 77 300 1002', 'Admin', 'Active', '2025-01-03 08:00:00'),
    (27, 'Robert Green',         'robert.green@mintora.com',        '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44 20 3000 1003','Admin', 'Active', '2025-01-04 08:00:00'),
    (28, 'Kavindi Dissanayake',  'kavindi.dissanayake@mintora.lk',  '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 76 300 1004', 'Admin', 'Active', '2025-01-05 08:00:00'),
    (29, 'Samuel Clark',         'samuel.clark@mintora.com',        '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1 617 555 1005','Admin', 'Active', '2025-01-06 08:00:00'),
    (30, 'Imesha Liyanage',      'imesha.liyanage@mintora.lk',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 70 300 1006', 'Admin', 'Active', '2025-01-07 08:00:00'),
    (31, 'Grace Lee',            'grace.lee@mintora.sg',            '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+65 6300 1007',   'Admin', 'Active', '2025-01-08 08:00:00'),
    (32, 'Dinuka Amarasinghe',   'dinuka.amarasinghe@mintora.lk',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 78 300 1008', 'Admin', 'Active', '2025-01-09 08:00:00'),
    (33, 'Laura Fischer',        'laura.fischer@mintora.de',        '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 30 3001 009','Admin', 'Active', '2025-01-10 08:00:00'),
    (34, 'Buddhika Kumara',      'buddhika.kumara@mintora.lk',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 300 1010', 'Admin', 'Active', '2025-01-11 08:00:00'),

    (35, 'Chamath Ranasinghe',   'chamath.ranasinghe@mintora.lk',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 77 400 2001', 'Manager', 'Active', '2025-01-02 09:00:00'),
    (36, 'Meera Fernando',       'meera.fernando@mintora.lk',       '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 71 400 2002', 'Manager', 'Active', '2025-01-03 09:00:00'),
    (37, 'Aaron Mitchell',       'aaron.mitchell@mintora.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+61 2 4002 003','Manager', 'Active', '2025-01-04 09:00:00'),
    (38, 'Sachini Pathirana',    'sachini.pathirana@mintora.lk',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 76 400 2004', 'Manager', 'Active', '2025-01-05 09:00:00'),
    (39, 'Daniel Evans',         'daniel.evans@mintora.co.uk',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44 20 4002 005','Manager', 'Active', '2025-01-06 09:00:00'),
    (40, 'Nethmi Fonseka',       'nethmi.fonseka@mintora.lk',       '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 75 400 2006', 'Manager', 'Active', '2025-01-07 09:00:00'),
    (41, 'Marcus Tan',           'marcus.tan@mintora.sg',           '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+65 6400 2007',   'Manager', 'Active', '2025-01-08 09:00:00'),
    (42, 'Hiruni Abeysekera',    'hiruni.abeysekera@mintora.lk',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 70 400 2008', 'Manager', 'Active', '2025-01-09 09:00:00'),
    (43, 'Anna Mueller',         'anna.mueller@mintora.de',         '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 30 4002 009','Manager', 'Active', '2025-01-10 09:00:00'),
    (44, 'Nimesh Ekanayake',     'nimesh.ekanayake@mintora.lk',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+94 78 400 2010', 'Manager', 'Active', '2025-01-11 09:00:00');

INSERT INTO `FREELANCER`
    (`Freelancer_ID`, `Bio`, `Hourly_Rate`, `Experience_Years`, `Portfolio_URL`, `Avg_Rating`)
VALUES
    (1,  'Machine learning engineer specializing in forecasting, feature engineering, and production model deployment.', 68.00, 7, 'https://github.com/kasun-perera/ml-portfolio', 4.82),
    (2,  'NLP specialist building Sinhala-English language models, sentiment systems, and intelligent chatbots.', 75.00, 8, 'https://www.linkedin.com/in/nadeesha-fernando-nlp', 4.91),
    (3,  'Computer vision consultant with experience in medical imaging, defect detection, and edge inference.', 82.00, 6, 'https://dhanushka-silva.github.io/computer-vision', 4.76),
    (4,  'Deep learning researcher focused on transformers, recommendation engines, and multimodal AI systems.', 105.00, 9, 'https://github.com/maya-patel/deep-learning', 4.95),
    (5,  'Data analyst creating reliable dashboards, statistical models, and KPI automation for growing businesses.', 45.00, 4, 'https://amaljayasinghe.example.lk/portfolio', 4.63),
    (6,  'Generative AI developer delivering RAG applications, prompt pipelines, and custom LLM integrations.', 95.00, 5, 'https://github.com/ruwan-wickramasinghe/gen-ai', 4.88),
    (7,  'AI product engineer experienced in MLOps, model monitoring, and scalable cloud ML infrastructure.', 120.00,10, 'https://oliviathompson.example.com/portfolio', 4.93),
    (8,  'Logistics analytics specialist using predictive modeling and optimization for fleet operations.', 58.00, 5, 'https://tharindubandara.example.lk/analytics', 4.55),
    (9,  'Natural language processing engineer building document extraction and multilingual search solutions.', 88.00, 7, 'https://sophiemartin.example.fr/nlp-work', 4.84),
    (10, 'Healthcare data scientist developing explainable risk models and clinical reporting tools.', 72.00, 6, 'https://chathurisamarasinghe.example.lk/data-science', 4.79),
    (11, 'Computer vision engineer specializing in autonomous systems, OCR, and video analytics.', 110.00, 8, 'https://ethanwilliams.example.com/cv-portfolio', 4.90),
    (12, 'Entry-level generative AI developer building content workflows and exploratory language applications.', 25.00, 1, 'https://pramodgunawardena.example.lk/ai-work', 4.10);

INSERT INTO `CLIENT`
    (`Client_ID`, `Client_Type`, `Company_Name`, `Industry`, `Country`)
VALUES
    (13, 'Individual',     NULL,                          'EdTech',       'Sri Lanka'),
    (14, 'Organization',   'Harbour FinTech Singapore',    'FinTech',      'Singapore'),
    (15, 'Organization',   'Ceylon Care Health Network',   'Healthcare',   'Sri Lanka'),
    (16, 'Organization',   'Northstar Commerce UK',        'E-Commerce',   'UK'),
    (17, 'Individual',     NULL,                          'AgriTech',     'Sri Lanka'),
    (18, 'Organization',   'Pacific Logistics Australia',  'Logistics',    'Australia'),
    (19, 'Organization',   'PearlTeach Technologies',      'EdTech',       'Sri Lanka'),
    (20, 'Organization',   'Digital Naira Solutions',      'FinTech',      'USA'),
    (21, 'Organization',   'Rhein Data Systems',           'Data Analytics','Germany'),
    (22, 'Individual',     NULL,                          'Healthcare',   'Sri Lanka'),
    (23, 'Organization',   'Manhattan Health Analytics',   'Healthcare',   'USA'),
    (24, 'Organization',   'Green Harvest Lanka',          'AgriTech',     'Sri Lanka');

INSERT INTO `ADMIN_STAFF`
    (`Admin_ID`, `Department`, `Access_Level`)
VALUES
    (25, 'Platform Operations', 'SuperAdmin'),
    (26, 'Trust & Safety',      'Standard'),
    (27, 'Dispute Resolution',  'SuperAdmin'),
    (28, 'User Verification',   'Standard'),
    (29, 'Compliance',          'SuperAdmin'),
    (30, 'Trust & Safety',      'Standard'),
    (31, 'Platform Operations', 'Standard'),
    (32, 'Dispute Resolution',  'Standard'),
    (33, 'Compliance',          'Standard'),
    (34, 'User Verification',   'Standard');

INSERT INTO `MANAGER`
    (`Manager_ID`, `Division`, `Report_Scope`)
VALUES
    (35, 'Revenue & Finance',       'Oversees platform revenue, fee configuration, payout reconciliation, and financial reporting.'),
    (36, 'AI Marketplace Growth',   'Manages freelancer acquisition, service catalog growth, and marketplace campaign performance.'),
    (37, 'Enterprise Accounts',     'Handles strategic enterprise clients, account retention, and large AI project opportunities.'),
    (38, 'Quality Assurance',       'Monitors proposal quality, project delivery standards, and freelancer performance reviews.'),
    (39, 'Product Analytics',       'Reports on marketplace engagement, conversion metrics, and user behavior insights.'),
    (40, 'AI Marketplace Growth',   'Coordinates regional marketplace expansion and Sri Lankan specialist recruitment.'),
    (41, 'Enterprise Accounts',     'Supports international client onboarding and cross-border enterprise partnerships.'),
    (42, 'Revenue & Finance',       'Reviews transaction trends, platform fees, refunds, and monthly financial forecasts.'),
    (43, 'Product Analytics',       'Owns product KPI dashboards, experiment analysis, and research data quality.'),
    (44, 'Quality Assurance',       'Supervises service quality audits and dispute prevention across assigned divisions.');


