/*
https://www.hackerrank.com/challenges/placements
 */
SELECT
    students.name
FROM
    students
    JOIN (
        SELECT
            p.id AS id,
            p.friend_id,
            p.my_salary,
            packages.salary AS f_salary
        FROM
            (
                SELECT
                    friends.id AS id,
                    friends.friend_id AS friend_id,
                    packages.salary AS my_salary
                FROM
                    friends
                    JOIN packages ON friends.id = packages.id
            ) AS p
            JOIN packages ON p.friend_id = packages.id
    ) AS t ON students.id = t.id
WHERE
    t.my_salary < t.f_salary
ORDER BY
    t.f_salary