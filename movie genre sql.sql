select round(avg(Total),1) as avg_genre from
(select t1.name,count(*) as Total from
(select m.title as name ,gm.genre_id from
genres_in_movies as gm
left join movies as m
on gm.movie_id=m.id) t1
group by 1) t2


select max(Total) as max_genre from
(select t1.name,count(*) as Total from
(select m.title as name ,gm.genre_id from
genres_in_movies as gm
left join movies as m
on gm.movie_id=m.id) t1
group by 1) t2