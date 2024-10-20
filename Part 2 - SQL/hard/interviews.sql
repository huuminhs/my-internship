/*
https://www.hackerrank.com/challenges/interviews
 */
with
    sub_s as (
        select
            challenge_id,
            sum(total_submissions) as total_sub,
            sum(total_accepted_submissions) as total_acc_sub
        from
            submission_stats
        group by
            challenge_id
    ),
    view_s as (
        select
            challenge_id,
            sum(total_views) as total_views,
            sum(total_unique_views) as total_unique_views
        from
            view_stats
        group by
            challenge_id
    ),
    m as (
        select
            challenge_id,
            contest_id
        from
            colleges
            join challenges on challenges.college_id = colleges.college_id
    ),
    n as (
        select
            m.contest_id,
            total_views as tv,
            total_unique_views as tuv
        from
            view_s
            join m on view_s.challenge_id = m.challenge_id
    ),
    o as (
        select
            m.contest_id,
            total_sub as ts,
            total_acc_sub as tas
        from
            sub_s
            join m on sub_s.challenge_id = m.challenge_id
    ),
    p as (
        select
            n.contest_id,
            sum(tv) as tv,
            sum(tuv) as tuv
        from
            n
            join contests on contests.contest_id = n.contest_id
        group by
            n.contest_id
    ),
    x as (
        select
            o.contest_id,
            sum(ts) as ts,
            sum(tas) as tas
        from
            o
            join contests on contests.contest_id = o.contest_id
        group by
            o.contest_id
    )
select
    contests.contest_id,
    hacker_id,
    name,
    ts,
    tas,
    tv,
    tuv
from
    contests
    join p on contests.contest_id = p.contest_id
    join x on x.contest_id = contests.contest_id
order by
    contests.contest_id;