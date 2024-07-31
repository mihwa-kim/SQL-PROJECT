-- Data Cleaning

SELECT * 
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns

-- 1. Remove Duplicates
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT * FROM layoffs;

SELECT company, industry, total_laid_off, `date`,
ROW_NUMBER() OVER ( 
PARTITION BY company,  
industry, 
total_laid_off, 
`date`) AS row_num
FROM layoffs_staging;

SELECT * FROM (
SELECT company, industry, total_laid_off, `date`,
ROW_NUMBER() OVER ( 
PARTITION BY company,  
industry, 
total_laid_off, 
`date`) AS row_num
FROM layoffs_staging ) duplicates WHERE row_num > 1 ;

SELECT *
FROM layoffs_staging
WHERE company = 'Oda';


WITH DELETE_CTE AS 
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging
) duplicates
WHERE 
	row_num > 1
)
DELETE
FROM DELETE_CTE
;

WITH DELETE_CTE AS (
	SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, 
    ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM world_layoffs.layoffs_staging
)
DELETE FROM world_layoffs.layoffs_staging
WHERE (company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num) IN (
	SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num
	FROM DELETE_CTE
) AND row_num > 1;

ALTER TABLE layoffs_staging ADD row_num INT;

SELECT * FROM layoffs_staging;

CREATE TABLE `world_layoffs`.`layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);

INSERT INTO `layoffs_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		layoffs_staging;
        
DELETE FROM layoffs_staging2
WHERE row_num >= 2;

-- 2. Standardize Data
SELECT * FROM layoffs_staging2;

SELECT DISTINCT industry FROM layoffs_staging2 ORDER BY industry;
SELECT * FROM layoffs_staging2 WHERE industry IS NULL OR industry = '' ORDER BY industry;
-- Let's take a look at these
SELECT * FROM layoffs_staging2 WHERE company LIKE 'Bally%';
SELECT * FROM layoffs_staging2 WHERE company LIKE 'airbnb%';

-- It looks like airbnb is a travel, but this one just isn't populated.
-- I'm sure it's the same for the others. What we can do is
-- write a query that if there is another row with the same company name, it will update it to the non-null industry values
-- makes it easy so if there were thousands we wouldn't have to manually check them all

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''
;
SELECT * FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
ORDER BY industry;

-- now we need to populate those nulls if possible
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry IS NULL
AND t2.industry IS NOT NULL

-- and if we check it looks like Bally's was the only one without a populated row to populate this null values
SELECT * FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
ORDER BY industry;

-- Crypto has multiple diff var. We need to standardize that - let's say all to Crypto
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency','CryptoCurrency');

SELECT DISTINCT industry
FROM layoffs_staging2 ORDER BY industry;

-- I also look at country and date
SELECT * FROM layoffs_staging2;
SELECT DISTINCT country FROM layoffs_staging2 ORDER BY country;

UPDATE layoffs_staging2 SET country = TRIM(TRAILING '.' FROM country);
SELECT DISTINCT country FROM layoffs_staging2 ORDER BY country;

UPDATE layoffs_staging2 SET `date` = str_to_date(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_staging2 MODIFY COLUMN `date` DATE;

-- 3. Look at NULL values
-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. I don't think I want to change that
-- I like having them null because it makes it easier for calculations during the EDA phase
-- so there isn't anything I want to change with the null values

-- 4. Remove any columns and rows we need to
SELECT * FROM layoffs_staging2 WHERE total_laid_off IS NULL;
SELECT * FROM layoffs_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE FROM layoffs_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2 DROP COLUMN row_num;











