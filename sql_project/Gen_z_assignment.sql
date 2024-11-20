-- what is the gender distribution of respodent from india?			
select gender,count(*)
from cleaning_data.assignment
where Country = "IND"
group by gender;

-- what percentage of respondents from india are interested in education abroad and sponsership?
select `Higher Education Aspiration`,concat(round(count(*)/(select count(*) from cleaning_data.assignment)*100,2),"%")
from cleaning_data.assignment
where Country="IND"
group by `Higher Education Aspiration`
having `Higher Education Aspiration`!= "no";


-- what are 6 top influences on career aspiration for respondent in india?	
select `influencing factors`,count(`desire career close to aspiration job`)as total
from cleaning_data.assignment
where country ="IND"
group by `influencing factors`
order by total desc
limit 6;


-- How do career aspiration influences vary by gender in india?	
with cte as(		
select `desire career close to aspiration job`,count(`influencing factors`)total,gender
from cleaning_data.assignment
where Country="IND"
group by gender,`desire career close to aspiration job`)
select `desire career close to aspiration job`,
max(case when gender ="M" then total end) as Male,
max(case when gender ="F" then total end) as Female,
max(case when gender ="other" then total end) as other
from cte
group by `desire career close to aspiration job`;


-- what percentage of respondents are willing to work for a company for atleast 3 years?			
select `3 year tenurity`,concat(round(count(*)/(select count(*) from cleaning_data.assignment)*100,2),"%") as percentage
from cleaning_data.assignment
where `3 year tenurity` = "yes"
group by `3 year tenurity`;


-- How many respondents prefer to work for socially impactful coompany?		
select `work for indifferent company`,count(`work for indifferent company`)as total
from cleaning_data.assignment
where `work for indifferent company`>5
group by `work for indifferent company`
order by `work for indifferent company`;

-- How does the preference for social impactful company vary by gender?	
select `work for indifferent company`,
max(case when gender ="M" then total end)as Male,
max(case when gender ="F" then total end)as Female,
max(case when gender ="Other" then total end)as Other
from(	
select `work for indifferent company`,gender,count(`work for indifferent company`) as total
from cleaning_data.assignment
group by `work for indifferent company`,gender)x
group by `work for indifferent company`
order by `work for indifferent company`;


-- What is the distribution of minimum expected salary in the first 3 years among respondents?			
select `expected Entry-level(3yrs)salary`,count(`expected Entry-level(3yrs)salary`)total
from cleaning_data.assignment
group by `expected Entry-level(3yrs)salary`
order by total ;

-- what is the expected minimum monthly salary in hand?
select `expected entry-level minimum salary`,count(`expected entry-level minimum salary`)as total
from cleaning_data.assignment
where `expected entry-level minimum salary`!=""
group by `expected entry-level minimum salary`
order by `expected entry-level minimum salary`;

-- 2nd query
select distinct`expected entry-level minimum salary`
from cleaning_data.assignment
where `expected entry-level minimum salary`!="";


-- what percentage of response prefer remote working?		
select `desire enviournment`,concat(round(count(`desire enviournment`)/(select count(`desire enviournment`)from cleaning_data.assignment)*100,2),"%")as percentage
from cleaning_data.assignment
where `desire enviournment` ="remote";


-- what is the preferred number of daily work?	
select `Balanced work hour`,count(`Balanced work hour`)as total
from cleaning_data.assignment
where `Balanced work hour`!="null"
group by `Balanced work hour`
order by total desc
limit 1;


-- what are the common work frustrations among respondent?		
select `Obstruction at work`,count(`Obstruction at work`)as total
from cleaning_data.assignment
where `Obstruction at work` != ""
group by `Obstruction at work`
order by total desc
limit 1;


-- How does the need for work life balance intervention vary by gender?	
select `Need sabbatical week`,
max(case when gender ="M" then total end)as Male,
max(case when gender ="F" then total end)as Female,
max(case when gender ="Other" then total end)as Other
from(		
select `Need sabbatical week`,gender,count(`Need sabbatical week`)total
from cleaning_data.assignment
where `Need sabbatical week` !=""
group by `Need sabbatical week`,gender)x
group by `Need sabbatical week`
order by `Need sabbatical week`;


-- Howmany respondents are willing to work under abusive manager?		
select count(`Work under toxic manager`)as willing_to_work_with_toxic_manager
from cleaning_data.assignment
where `Work under toxic manager`="yes";

-- what is the distribution of minimum expected salary after 5 years?	
select distinct`expected mid-level(after 5yrs)salary`
from cleaning_data.assignment
order by 1;

-- what are the remote working preferences by gender?	
select gender,count(gender)as total
from cleaning_data.assignment
where `desire enviournment` ="remote"
group by gender;

-- what are the top work frustrations for each gender?

select `Obstruction at work`,
 count(case when gender ="M" then 1 end)as Male,
 count(case when gender ="F" then 1 end)as Female,
 count(case when gender ="Other" then 1 end)as Other
 from cleaning_data.assignment
where `Obstruction at work` != ""
group by `Obstruction at work`
order by 2 desc,3 desc,4 desc
limit 4
;
 
 -- what factors boost work happiness and productivity for respondents?				
select distinct `Motivation at work`,count(`Motivation at work`)as total
from cleaning_data.assignment
where `Motivation at work` !=""
group by `Motivation at work`;


-- what percentage of respondents need sponsership for education abroad?			
select `Higher Education Aspiration`,concat(round(count(`Higher Education Aspiration`)/(select count(*) from cleaning_data.assignment)*100,2),"%")as percentage
from cleaning_data.assignment
where `Higher Education Aspiration` ="need sponser";
