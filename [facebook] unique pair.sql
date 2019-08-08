/*有一道题是这样，表格有两列:
id, type

1, A
2, A
3, A

问所有type相同的id unique pair，比如例子里的这个表的答案就应该是：
1, 2
1, 3
2, 3

返回的结果写成1, 2或者2, 1都行，但如果写了1, 2，就视为这个pair已经出现过了，不能再写一遍2, 1
*/


-- creating table
DROP TABLE IF EXISTS q1;
CREATE TABLE q1 (id int, label char(10));

-- insert value
INSERT INTO q1 VALUES (1, "A");
INSERT INTO q1 VALUES (2, "A");
INSERT INTO q1 VALUES (3, "A");

-- Answer 1
select t1.id, t2.id
from q1 as t1
left join q1 as t2
on t1.label=t2.label 
where t1.id<t2.id

