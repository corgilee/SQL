/*

https://leetcode.com/articles/friend-requests-i-overall-acceptance-rate/

*/






-- creating table
CREATE TABLE friend_request (sender_id int, send_to_id int, request_date date);

--insert value
INSERT INTO friend_request VALUES (1,2, '2016-06-01');
INSERT INTO friend_request VALUES (1,2, '2016-06-01');
INSERT INTO friend_request VALUES (1,3, '2016-06-01');
INSERT INTO friend_request VALUES (1,4, '2016-07-01');
INSERT INTO friend_request VALUES (2,3, '2016-07-02');
INSERT INTO friend_request VALUES (3,4, '2016-07-09');


-- creating employee_sex table in Oracle
CREATE TABLE request_accepted (requester_id int, accepter_id int, accept_date date);


INSERT INTO request_accepted  VALUES (1,2, '2016-06-03');
INSERT INTO request_accepted  VALUES (1,3, '2016-06-08');
INSERT INTO request_accepted  VALUES (2,3, '2016-07-08');
INSERT INTO request_accepted  VALUES (3,4, '2016-07-09');
INSERT INTO request_accepted  VALUES (3,4, '2016-07-10');

drop table friend_request




-- follow up 1: Can you write a query to return the accept rate but for every month?
select (count(t3.accept_date)/count(t3.request_date)) as accept_rate ,month(t3.request_date) as request_mon
from
(select distinct t1.*, t2.accept_date
from friend_request t1
left join
(select distinct * from request_accepted) t2
on t1.sender_id=t2.requester_id and t1.send_to_id=t2.accepter_id) t3
group by request_mon

-- follow up 2: How about the cumulative accept rate for every day?

create table t3 as
select distinct t1.*, t2.accept_date
from friend_request t1
left join
(select distinct * from request_accepted) t2
on t1.sender_id=t2.requester_id and t1.send_to_id=t2.accepter_id

/*
set request_date as d, create the "accumulative" by comparing date with d (reference)
*/
select request_date as d,
((select count(*) from t3 where accept_date<=d) /(select count(*) from t3 where request_date<=d)) as accept_rate
from t3 
group by d
order by d 

