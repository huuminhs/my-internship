/*
https://www.hackerrank.com/challenges/the-company
 */
SELECT
    company.company_code,
    company.founder,
    tmp.lead,
    tmp2.se,
    tmp3.mana,
    tmp4.emp
FROM
    company
    JOIN (
        SELECT
            COUNT(DISTINCT lead_manager_code) AS lead,
            company_code
        FROM
            lead_manager
        GROUP BY
            company_code
    ) AS tmp ON company.company_code = tmp.company_code
    JOIN (
        SELECT
            COUNT(DISTINCT senior_manager_code) AS se,
            company_code
        FROM
            senior_manager
        GROUP BY
            company_code
    ) AS tmp2 ON company.company_code = tmp2.company_code
    JOIN (
        SELECT
            COUNT(DISTINCT manager_code) AS mana,
            company_code
        FROM
            manager
        GROUP BY
            company_code
    ) AS tmp3 ON company.company_code = tmp3.company_code
    JOIN (
        SELECT
            COUNT(DISTINCT employee_code) AS emp,
            company_code
        FROM
            employee
        GROUP BY
            company_code
    ) AS tmp4 ON company.company_code = tmp4.company_code
ORDER BY
    company.company_code ASC