DROP FUNCTION IF EXISTS Func_Class;
Delimiter //
CREATE FUNCTION Func_Class(Marks Integer)
RETURNS varchar(25) NO SQL
   BEGIN
	DECLARE S_result varchar(25);
  IF (Marks>=990 AND Marks<=1500) then
	SET S_result = 'DISTINCTION';
  ELSEIF (Marks>=900 AND Marks<=989) THEN
	SET S_result = 'FIRST CLASS';
  ELSEIF (Marks>=825 AND Marks<=899) THEN
	SET S_result = 'HIGHER SECOND CLASS';
  ELSE
	SET S_result = 'PASS CLASS';  
  END IF;
	RETURN S_result;
END;
//
Delimiter ;
