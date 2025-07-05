DELIMITER //
CREATE DATABASE task8;
use task8;
DELIMITER //

CREATE FUNCTION GetFullName(sid INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(100);

    SELECT CONCAT(first_name, ' ', last_name)
    INTO full_name
    FROM Students
    WHERE student_id = sid;

    RETURN full_name;
END //

DELIMITER ;

