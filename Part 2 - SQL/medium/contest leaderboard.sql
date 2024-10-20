/*
https://www.hackerrank.com/challenges/contest-leaderboard/
 */
SELECT
    hackers.hacker_id,
    hackers.name,
    m.s
FROM
    hackers
    JOIN (
        SELECT
            hacker_id,
            SUM(s) AS s
        FROM
            (
                SELECT
                    hacker_id,
                    MAX(score) AS s
                FROM
                    submissions
                GROUP BY
                    hacker_id,
                    challenge_id
            ) AS p
        GROUP BY
            hacker_id
    ) AS m ON hackers.hacker_id = m.hacker_id
WHERE
    m.s != 0
ORDER BY
    m.s DESC,
    hacker_id ASC