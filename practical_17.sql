DROP PROCEDURE IF EXISTS merge_Data;
DELIMITER //

CREATE PROCEDURE merge_Data(IN newRollno INTEGER)

BEGIN
    DECLARE S_Roll INTEGER;
    DECLARE row_Count INTEGER DEFAULT 0;

    DECLARE terminate BOOLEAN DEFAULT FALSE;

    DECLARE Stud_detail CURSOR FOR 
    SELECT Rollno FROM student WHERE Rollno = newRollno;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminate = TRUE;
    
    OPEN Stud_detail;

    getStud: LOOP
       FETCH Stud_detail INTO S_Roll;
       IF NOT EXISTS (SELECT * FROM n_Student WHERE Rollno = S_Roll) Then
	 INSERT INTO n_Student SELECT * FROM student WHERE Rollno=S_Roll;
         SET row_Count = row_Count + 1;
       END IF;

       IF terminate = TRUE THEN
           LEAVE getStud;
       END IF;
           END LOOP getStud;
    CLOSE Stud_detail;
    SELECT CONCAT('RECORDS MERGED,',row_Count,' row(s) affected') AS Message;
END //
DELIMITER ;
