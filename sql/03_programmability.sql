USE mintora_db;

DROP TRIGGER IF EXISTS trg_calculate_payment_fee;
DROP TRIGGER IF EXISTS trg_update_freelancer_rating;

DELIMITER //

CREATE TRIGGER trg_calculate_payment_fee
BEFORE INSERT ON PAYMENT
FOR EACH ROW
BEGIN
    SET NEW.Platform_Fee = ROUND(NEW.Amount_Paid * 0.10, 2);
    SET NEW.Net_Freelancer_Amount = ROUND(NEW.Amount_Paid - NEW.Platform_Fee, 2);
END//

CREATE TRIGGER trg_update_freelancer_rating
AFTER INSERT ON REVIEW
FOR EACH ROW
BEGIN
    UPDATE FREELANCER
    SET Avg_Rating = COALESCE(
        (
            SELECT ROUND(AVG(Rating), 2)
            FROM REVIEW
            WHERE Reviewee_ID = NEW.Reviewee_ID
        ),
        0.00
    )
    WHERE Freelancer_ID = NEW.Reviewee_ID;
END//

DELIMITER ;

-- [MEMBER 2: USER-DEFINED FUNCTIONS (2 UDFs)]

-- [MEMBER 3: STORED PROCEDURE 1 - ACCEPT PROPOSAL]

-- [MEMBER 4: STORED PROCEDURE 2 - RESOLVE DISPUTE]

-- [MEMBER 5: VIEWS (3) & STORED PROCEDURE 3 - REVENUE REPORT]
