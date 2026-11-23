-- MINTORA database schema
-- Drop and recreate the database so this script can be imported on a fresh XAMPP setup.
DROP DATABASE IF EXISTS mintora_db;
CREATE DATABASE mintora_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mintora_db;

CREATE TABLE `USER` (
    `User_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Full_Name` VARCHAR(150) NOT NULL,
    `Email` VARCHAR(190) NOT NULL,
    `Password_Hash` VARCHAR(255) NOT NULL,
    `Phone` VARCHAR(30) NULL,
    `User_Role` ENUM('Freelancer','Client','Admin','Manager') NOT NULL,
    `Account_Status` ENUM('Active','Suspended','Pending') NOT NULL DEFAULT 'Active',
    `Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`User_ID`),
    UNIQUE KEY `uq_user_email` (`Email`)
) ENGINE=InnoDB;

CREATE TABLE `FREELANCER` (
    `Freelancer_ID` INT UNSIGNED NOT NULL,
    `Bio` TEXT NULL,
    `Hourly_Rate` DECIMAL(10,2) NULL,
    `Experience_Years` INT UNSIGNED NOT NULL DEFAULT 0,
    `Portfolio_URL` VARCHAR(255) NULL,
    `Avg_Rating` DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`Freelancer_ID`),
    CONSTRAINT `fk_freelancer_user`
        FOREIGN KEY (`Freelancer_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `chk_freelancer_rate` CHECK (`Hourly_Rate` IS NULL OR `Hourly_Rate` >= 0),
    CONSTRAINT `chk_freelancer_rating` CHECK (`Avg_Rating` BETWEEN 0.00 AND 5.00)
) ENGINE=InnoDB;

CREATE TABLE `CLIENT` (
    `Client_ID` INT UNSIGNED NOT NULL,
    `Client_Type` ENUM('Individual','Organization') NOT NULL,
    `Company_Name` VARCHAR(150) NULL,
    `Industry` VARCHAR(150) NULL,
    `Country` VARCHAR(100) NULL,
    PRIMARY KEY (`Client_ID`),
    CONSTRAINT `fk_client_user`
        FOREIGN KEY (`Client_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `ADMIN_STAFF` (
    `Admin_ID` INT UNSIGNED NOT NULL,
    `Department` VARCHAR(150) NULL,
    `Access_Level` ENUM('Standard','SuperAdmin') NOT NULL DEFAULT 'Standard',
    PRIMARY KEY (`Admin_ID`),
    CONSTRAINT `fk_admin_user`
        FOREIGN KEY (`Admin_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `MANAGER` (
    `Manager_ID` INT UNSIGNED NOT NULL,
    `Division` VARCHAR(150) NULL,
    `Report_Scope` TEXT NULL,
    PRIMARY KEY (`Manager_ID`),
    CONSTRAINT `fk_manager_user`
        FOREIGN KEY (`Manager_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `AI_SKILL` (
    `Skill_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Skill_Name` VARCHAR(150) NOT NULL,
    `AI_Category` ENUM('Machine Learning','Deep Learning','Natural Language Processing','Computer Vision','Generative AI','Data Analytics') NOT NULL,
    `Description` TEXT NULL,
    PRIMARY KEY (`Skill_ID`),
    UNIQUE KEY `uq_skill_name` (`Skill_Name`)
) ENGINE=InnoDB;

CREATE TABLE `FREELANCER_SKILL` (
    `Freelancer_ID` INT UNSIGNED NOT NULL,
    `Skill_ID` INT UNSIGNED NOT NULL,
    `Proficiency_Level` ENUM('Beginner','Intermediate','Advanced','Expert') NOT NULL,
    `Years_Used` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`Freelancer_ID`, `Skill_ID`),
    CONSTRAINT `fk_freelancer_skill_user`
        FOREIGN KEY (`Freelancer_ID`) REFERENCES `FREELANCER` (`Freelancer_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_freelancer_skill`
        FOREIGN KEY (`Skill_ID`) REFERENCES `AI_SKILL` (`Skill_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `AI_SERVICE` (
    `Service_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Freelancer_ID` INT UNSIGNED NOT NULL,
    `Skill_ID` INT UNSIGNED NOT NULL,
    `Service_Title` VARCHAR(180) NOT NULL,
    `Description` TEXT NULL,
    `Base_Price` DECIMAL(10,2) NOT NULL,
    `Delivery_Days` INT UNSIGNED NOT NULL,
    `Is_Active` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`Service_ID`),
    CONSTRAINT `fk_service_freelancer`
        FOREIGN KEY (`Freelancer_ID`) REFERENCES `FREELANCER` (`Freelancer_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_service_skill`
        FOREIGN KEY (`Skill_ID`) REFERENCES `AI_SKILL` (`Skill_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_service_price` CHECK (`Base_Price` >= 0),
    CONSTRAINT `chk_service_active` CHECK (`Is_Active` IN (0,1))
) ENGINE=InnoDB;

CREATE TABLE `PROJECT` (
    `Project_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Client_ID` INT UNSIGNED NOT NULL,
    `Project_Title` VARCHAR(180) NOT NULL,
    `Description` TEXT NULL,
    `Budget_Amount` DECIMAL(10,2) NOT NULL,
    `Deadline_Date` DATE NOT NULL,
    `Project_Status` ENUM('Open','In Progress','Completed','Cancelled') NOT NULL DEFAULT 'Open',
    `Posted_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`Project_ID`),
    CONSTRAINT `fk_project_client`
        FOREIGN KEY (`Client_ID`) REFERENCES `CLIENT` (`Client_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `chk_project_budget` CHECK (`Budget_Amount` >= 0)
) ENGINE=InnoDB;

CREATE TABLE `PROJECT_REQUIREMENT` (
    `Project_ID` INT UNSIGNED NOT NULL,
    `Skill_ID` INT UNSIGNED NOT NULL,
    `Required_Level` ENUM('Beginner','Intermediate','Advanced','Expert') NOT NULL,
    `Is_Mandatory` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`Project_ID`, `Skill_ID`),
    CONSTRAINT `fk_requirement_project`
        FOREIGN KEY (`Project_ID`) REFERENCES `PROJECT` (`Project_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_requirement_skill`
        FOREIGN KEY (`Skill_ID`) REFERENCES `AI_SKILL` (`Skill_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_requirement_mandatory` CHECK (`Is_Mandatory` IN (0,1))
) ENGINE=InnoDB;

CREATE TABLE `PROPOSAL` (
    `Proposal_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Project_ID` INT UNSIGNED NOT NULL,
    `Freelancer_ID` INT UNSIGNED NOT NULL,
    `Bid_Amount` DECIMAL(10,2) NOT NULL,
    `Estimated_Days` INT UNSIGNED NOT NULL,
    `Cover_Letter` TEXT NULL,
    `Proposal_Status` ENUM('Pending','Accepted','Rejected','Withdrawn') NOT NULL DEFAULT 'Pending',
    `Submitted_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`Proposal_ID`),
    UNIQUE KEY `uq_project_freelancer` (`Project_ID`, `Freelancer_ID`),
    CONSTRAINT `fk_proposal_project`
        FOREIGN KEY (`Project_ID`) REFERENCES `PROJECT` (`Project_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_proposal_freelancer`
        FOREIGN KEY (`Freelancer_ID`) REFERENCES `FREELANCER` (`Freelancer_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `chk_proposal_bid` CHECK (`Bid_Amount` >= 0)
) ENGINE=InnoDB;

CREATE TABLE `PROJECT_ASSIGNMENT` (
    `Assignment_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Project_ID` INT UNSIGNED NOT NULL,
    `Proposal_ID` INT UNSIGNED NOT NULL,
    `Freelancer_ID` INT UNSIGNED NOT NULL,
    `Agreed_Amount` DECIMAL(10,2) NOT NULL,
    `Start_Date` DATE NOT NULL,
    `Completion_Date` DATE NULL DEFAULT NULL,
    `Assignment_Status` ENUM('Active','Completed','Disputed','Terminated') NOT NULL DEFAULT 'Active',
    PRIMARY KEY (`Assignment_ID`),
    UNIQUE KEY `uq_assignment_project` (`Project_ID`),
    UNIQUE KEY `uq_assignment_proposal` (`Proposal_ID`),
    CONSTRAINT `fk_assignment_project`
        FOREIGN KEY (`Project_ID`) REFERENCES `PROJECT` (`Project_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_assignment_proposal`
        FOREIGN KEY (`Proposal_ID`) REFERENCES `PROPOSAL` (`Proposal_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_assignment_freelancer`
        FOREIGN KEY (`Freelancer_ID`) REFERENCES `FREELANCER` (`Freelancer_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_assignment_amount` CHECK (`Agreed_Amount` >= 0)
) ENGINE=InnoDB;

CREATE TABLE `PAYMENT` (
    `Payment_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Assignment_ID` INT UNSIGNED NOT NULL,
    `Amount_Paid` DECIMAL(10,2) NOT NULL,
    `Platform_Fee` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `Net_Freelancer_Amount` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `Payment_Method` ENUM('Credit Card','Bank Transfer','PayPal','Online Gateway') NOT NULL,
    `Payment_Status` ENUM('Pending','Completed','Failed','Refunded') NOT NULL DEFAULT 'Pending',
    `Paid_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`Payment_ID`),
    CONSTRAINT `fk_payment_assignment`
        FOREIGN KEY (`Assignment_ID`) REFERENCES `PROJECT_ASSIGNMENT` (`Assignment_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `chk_payment_amount` CHECK (`Amount_Paid` >= 0),
    CONSTRAINT `chk_platform_fee` CHECK (`Platform_Fee` >= 0),
    CONSTRAINT `chk_net_amount` CHECK (`Net_Freelancer_Amount` >= 0)
) ENGINE=InnoDB;

CREATE TABLE `REVIEW` (
    `Review_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Assignment_ID` INT UNSIGNED NOT NULL,
    `Reviewer_ID` INT UNSIGNED NOT NULL,
    `Reviewee_ID` INT UNSIGNED NOT NULL,
    `Rating` TINYINT NOT NULL,
    `Comment` TEXT NULL,
    `Reviewed_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`Review_ID`),
    UNIQUE KEY `uq_assignment_reviewer` (`Assignment_ID`, `Reviewer_ID`),
    CONSTRAINT `fk_review_assignment`
        FOREIGN KEY (`Assignment_ID`) REFERENCES `PROJECT_ASSIGNMENT` (`Assignment_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_review_reviewer`
        FOREIGN KEY (`Reviewer_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_review_reviewee`
        FOREIGN KEY (`Reviewee_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_review_rating` CHECK (`Rating` BETWEEN 1 AND 5)
) ENGINE=InnoDB;

CREATE TABLE `DISPUTE` (
    `Dispute_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Assignment_ID` INT UNSIGNED NOT NULL,
    `Raised_By_User_ID` INT UNSIGNED NOT NULL,
    `Resolved_By_Admin_ID` INT UNSIGNED NULL DEFAULT NULL,
    `Reason` TEXT NOT NULL,
    `Dispute_Status` ENUM('Open','Under Review','Resolved','Closed') NOT NULL DEFAULT 'Open',
    `Resolution_Notes` TEXT NULL DEFAULT NULL,
    `Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`Dispute_ID`),
    CONSTRAINT `fk_dispute_assignment`
        FOREIGN KEY (`Assignment_ID`) REFERENCES `PROJECT_ASSIGNMENT` (`Assignment_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_dispute_raised_by`
        FOREIGN KEY (`Raised_By_User_ID`) REFERENCES `USER` (`User_ID`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_dispute_admin`
        FOREIGN KEY (`Resolved_By_Admin_ID`) REFERENCES `ADMIN_STAFF` (`Admin_ID`)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;
