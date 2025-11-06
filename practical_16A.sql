DROP PROCEDURE IF EXISTS proc_Class;
use collegeexam;

DELIMITER //

CREATE PROCEDURE proc_Class(IN new_Roll INT)
BEGIN
    DECLARE T_Marks INT;
    DECLARE S_Name VARCHAR(25);
    DECLARE S_result VARCHAR(25);

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SELECT CONCAT('Roll ', new_Roll, ' NOT FOUND') AS NoRecord;
    END;

    SELECT Name, Total_Marks 
    INTO S_Name, T_Marks
    FROM Stud_Marks 
    WHERE Roll = new_Roll;  -- ✅ correct column

    SET S_result = Func_Class(T_Marks);

    INSERT INTO Result VALUES (new_Roll, S_Name, S_result);
END;
//
DELIMITER ;
