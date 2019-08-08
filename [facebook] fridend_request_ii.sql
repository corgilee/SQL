/*

https://leetcode.com/articles/friend-requests-ii-who-has-most-friend/
Friend Requests II

Write a query to find the the people who has most friends and the most friends number. 


Follow-up:
In the real world, multiple people could have the same most number of friends, can you find all these people in this case?

*/

-- creating table
drop table if exists friend_request_ii;
CREATE TABLE friend_request_ii (requester_id int, accepter_id int, accept_date date);


-- insert value
INSERT INTO friend_request_ii VALUES (1,2, '2016-06-03');
INSERT INTO friend_request_ii VALUES (1,3, '2016-06-08');
INSERT INTO friend_request_ii VALUES (2,3, '2016-06-08');
INSERT INTO friend_request_ii VALUES (3,4, '2016-06-09');



-- Q1:
select id, count(*) as num_of_friend
from 
(select requester_id as id
from friend_request_ii
union all
select accepter_id as id
from friend_request_ii) t1
group by id
order by num_of_friend desc
limit 1


-- follow up
INSERT INTO friend_request_ii VALUES (2,4, '2016-06-10');

/*
now both 2 and 3 has highest number of friend
*/

create table t1 as 
select id, count(*) as num_of_friend
from 
(select requester_id as id
from friend_request_ii
union all
select accepter_id as id
from friend_request_ii) t1
group by id
order by num_of_friend desc


select t1.id
from (select max(num_of_friend) as max_friend from t1) t2
left join t1
on t2.max_friend = t1.num_of_friend

