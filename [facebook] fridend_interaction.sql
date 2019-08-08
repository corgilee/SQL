/*
https://www.1point3acres.com/bbs/forum.php?mod=viewthread&tid=502533&extra=page%3D2&page=1
*/



-- creating table
DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (uid1 int, uid2 int);

-- insert value
INSERT INTO tbl VALUES (123, 456);
INSERT INTO tbl VALUES (456, 123);
INSERT INTO tbl VALUES (123, 467);
INSERT INTO tbl VALUES (376, 389);


DROP TABLE IF EXISTS tbl1;
CREATE TABLE tbl1 (sid int, rid int, action char(10), content char(10),content_id int, YYYYMMDD date);

-- insert value
INSERT INTO tbl1 VALUES (123, 456,"create",'comment',1234567, '2018-03-01');
INSERT INTO tbl1 VALUES (123, 456,"delete",'comment',1678294, '2018-03-01');
INSERT INTO tbl1 VALUES (123, 234,"create",'share',1456789, '2018-03-01');
INSERT INTO tbl1 VALUES (678, 456,"create",'comment',1456789, '2018-03-01');




-- tbl:
/*
注意这个表会有重复的，比如 (123,456), (456, 123) 是重复的

Q1: 选出最多friend的前10个user，因为这个表会重复，比如123，456，然后又来一个456，123 所以要做一些变动, 把uid 小的都放在左边，uid大的都放右边，这样不会重复计算

*/

CREATE VIEW t AS
SELECT uid1 AS id1, uid2 AS id2 FROM tbl WHERE uid1<uid2
UNION
SELECT uid2 AS id1,uid1 AS id2 FROM tbl WHERE uid1>uid2;



select * from
(select t2.id,dense_rank() over (order by total desc) as rk
from
(select t1.id, count(*) as total
from 
(SELECT id1 AS id FROM t
UNION ALL
SELECT id2 AS id FROM t) t1
group by t1.id) t2
) t3
where rk<=10

/*
Q2:

应该是说第二个表中是不会出现重复的，但是output出来的需要重复，就是第一行的这个interaction应该要在output里算两次（分别算在user1 123 user2 456 和user1 456 user2 123里）。。
我的理解是这样。。因为我只找出了第二个表中的每一对sender和recipent的interaction数量，但是面试官说不完整，要结合第一个表。。
*/

/*
不一定对，1. union all, 2.innder join 3.union
*/
select t1.* 
from
(select sid as id1, rid as id2, action, content, content_id from tbl1 where action='create'
union all
select rid as id1, sid as id2, action, content, content_id from tbl1 where action='create') t1
inner join tbl
on t1.id1=tbl.uid1 and t1.id2=tbl.uid2
union 
select sid as id1, rid as id2, action, content, content_id from tbl1 where action ='create'