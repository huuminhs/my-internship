/*
https://www.hackerrank.com/challenges/challenges
 */
WITH
    c AS (
        SELECT
            hacker_id,
            COUNT(challenge_id) AS c_count
        FROM
            challenges
        GROUP BY
            hacker_id
    ),
    ranked_c AS (
        SELECT
            hacker_id,
            c_count,
            (
                COUNT(*) OVER (
                    PARTITION BY
                        c_count
                )
            ) AS rn
        FROM
            c
    ),
    p AS (
        SELECT
            hacker_id,
            c_count,
            rn,
            MAX(c_count) OVER () AS max_count
        FROM
            ranked_c
    ),
    q AS (
        SELECT
            hacker_id,
            c_count
        FROM
            p
        WHERE
            rn = 1
            OR c_count = max_count
    )
SELECT
    q.hacker_id,
    hackers.name,
    q.c_count
FROM
    q
    JOIN hackers ON q.hacker_id = hackers.hacker_id
ORDER BY
    q.c_count DESC,
    q.hacker_id