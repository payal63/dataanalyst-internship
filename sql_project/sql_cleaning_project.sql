-- -**************** cleaning data project **********************

select *
from cleaning_data.layoffs;

desc cleaning_data.layoffs;

select *
from cleaning_data.layoffs;

create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;

with cte as
(
select * ,
row_number() over(partition by company,location,industry,total_laid_off,date,stage,country,funds_raised_millions) rn
from layoffs_staging)
select * from cte 
where rn>1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rn` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
drop table layoffs_staging2;


insert into layoffs_staging2
select * ,
row_number() over(partition by company,location,industry,total_laid_off,date,stage,country,funds_raised_millions) rn
from layoffs_staging;

delete
from layoffs_staging2
where rn>1;

select * from layoffs_staging2;

-- *****************standardize the data *********************-
select company,trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry 
from layoffs_staging2
order by 1;

select *
from layoffs_staging2 where industry like "crypto%";

update layoffs_staging2
set industry ="crypto"
where industry like "crypto%";

select trim(country),trim(trailing '.' from country)
from layoffs_staging2
order by country desc;

update layoffs_staging2
set country =trim(trailing '.' from country)
where country like "united state%";

select date,str_to_date(date,'%m/%d/%Y')
from layoffs_staging2
where date = "7/25/2022";


update layoffs_staging2
set date = str_to_date(date,'%m/%d/%Y');


alter table layoffs_staging2
modify column date  date;


desc layoffs_staging2;

-- ***********************Deal with null value*****************
select *
from layoffs_staging2
where industry is null ;


update layoffs_staging2
set industry =null
where industry =""; 

select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2 on t1.company=t2.company 
			and t1.location=t2.location
            where t1.industry is null 
            and t2.industry is not null;
            
update layoffs_staging2 t1
join layoffs_staging2 t2 on t1.company=t2.company 
			and t1.location=t2.location
set t1.industry=t2.industry
where t1.industry is null 
            and t2.industry is not null;
            
select *
from layoffs_staging2
where industry is null;

delete from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

select *
from layoffs_staging2;


-- ******************remove column*************************
alter table layoffs_staging2
drop rn;

select *
from layoffs_staging2;

