/*
https://www.hackerrank.com/challenges/the-report
 */
SELECT
    (
        CASE
            WHEN grade < 8 THEN NULL
            ELSE nested.name
        END
    ),
    grade,
    marks
FROM
    (
        SELECT
            (
                CASE
                    WHEN marks = 100 THEN 10
                    ELSE (marks DIV 10) + 1
                END
            ) AS grade,
            name,
            marks
        FROM
            Students
        ORDER BY
            grade DESC,
            name ASC,
            marks ASC
    ) AS nested