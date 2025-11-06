

DELIMITER //

CREATE PROCEDURE BookFine(IN roll_new INT, IN book_name VARCHAR(30))
BEGIN
    DECLARE X INT;

    -- Exception handler for not found record
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SELECT CONCAT('ROLL ', roll_new, ' NOT FOUND') AS NoRecord;
    END;

    -- Calculate number of days since book issue
    SELECT DATEDIFF(CURDATE(), DateofIssue)
    INTO X
    FROM Borrower
    WHERE Roll_no = roll_new AND NameofBook = book_name;

    -- Fine calculation
    IF (X > 15 AND X <= 30) THEN
        INSERT INTO Fine VALUES (roll_new, CURDATE(), (X * 5));
    END IF;

    IF (X > 30) THEN
        INSERT INTO Fine VALUES (roll_new, CURDATE(), (X * 50));
    END IF;

    -- Update borrower status
    UPDATE Borrower
    SET Status = 'R'
    WHERE Roll_no = roll_new AND NameofBook = book_name;
END;
//

DELIMITER ;
