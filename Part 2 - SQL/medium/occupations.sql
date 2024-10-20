/*
https://www.hackerrank.com/challenges/occupations
 */
SELECT
    doc.name,
    prof.name,
    si.name,
    act.name
FROM
    (
        SELECT
            name,
            ROW_NUMBER() OVER (
                ORDER BY
                    name
            ) AS rn
        FROM
            occupations
        WHERE
            occupation = 'Professor'
    ) AS prof
    FULL OUTER JOIN (
        SELECT
            name,
            ROW_NUMBER() OVER (
                ORDER BY
                    name
            ) AS rn
        FROM
            occupations
        WHERE
            occupation = 'Doctor'
    ) AS doc ON prof.rn = doc.rn
    FULL OUTER JOIN (
        SELECT
            name,
            ROW_NUMBER() OVER (
                ORDER BY
                    name
            ) AS rn
        FROM
            occupations
        WHERE
            occupation = 'Singer'
    ) AS si ON si.rn = prof.rn
    FULL OUTER JOIN (
        SELECT
            name,
            ROW_NUMBER() OVER (
                ORDER BY
                    name
            ) AS rn
        FROM
            occupations
        WHERE
            occupation = 'Actor'
    ) AS act ON act.rn = prof.rn