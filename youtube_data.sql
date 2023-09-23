Select * From youtube_data
Limit 5

-- Check distinct categories of Youtube Channel

SELECT DISTINCT(category) FROM youtube_data
ORDER BY category ASC

-- See CATEOGRY wise subscribers and their views

SELECT category, SUM(subscribers) AS Total_subscribers,
SUM(video_views) AS Total_view FROM youtube_data
WHERE categOry IS NOT NULL
GROUP BY category
ORDER BY Total_subscribers DESC

-- Top channel in each country

SELECT country, youtuber FROM youtube_data
WHERE country_rank = 1

-- USE of OLAP for better overview

SELECT country, category, COUNT(*) As Category FROM youtube_data
GROUP BY CUBE(country, category)
ORDER BY country

-- USE of ROLLUP for better overview  

SELECT country, category, COUNT(*) As Category FROM youtube_data
GROUP BY ROLLUP(country, category)
ORDER BY country

-- Enter Row Number and get even rows
With row_data AS(
Select youtuber, subscribers, ROW_Number() OVER() AS rowss  FROM youtube_data)
Select * from row_data
where mod(rowss,2)=0

-- country wise top channel
WITH datas as(
Select country,category, youtuber, subscribers, ROW_Number()
OVER(Partition by country order by subscribers Desc) AS rown FROM youtube_data)
Select * from datas
where rown = 1
						   
												