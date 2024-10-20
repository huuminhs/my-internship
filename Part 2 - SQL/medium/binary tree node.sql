/*
https://www.hackerrank.com/challenges/binary-search-tree-1
 */
SELECT
    N,
    (
        CASE
            WHEN P IS NULL THEN 'Root'
            WHEN (
                N NOT IN (
                    SELECT DISTINCT
                        (P)
                    FROM
                        BST
                    WHERE
                        P IS NOT NULL
                )
            ) THEN 'Leaf'
            ELSE 'Inner'
        END
    )
FROM
    BST
ORDER BY
    N ASC