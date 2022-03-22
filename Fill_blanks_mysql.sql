Create database fill_blanks;

USE fill_blanks;

-- fill the blanks
UPDATE input,
    (SELECT 
        *
    FROM
        input
    WHERE
        `lesson name` IS NOT NULL
            AND `subject` IS NOT NULL
    GROUP BY Weekday , Teacher) AS N 
SET 
    input.`lesson name` = N.`lesson name`,
    input.subject = N.subject
WHERE
    input.Weekday = N.Weekday
        AND input.teacher = N.teacher
;

-- calculate average
ALTER TABLE input ADD AVG_attendance DECIMAL(4,2);
UPDATE input,
(SELECT 
        Weekday, Teacher, AVG(attendance) as avg_a
    FROM
        input
    GROUP BY Weekday , Teacher) AS N 
SET
input.AVG_attendance=avg_a
WHERE  
     input.Weekday = N.Weekday
        AND input.teacher = N.teacher;
