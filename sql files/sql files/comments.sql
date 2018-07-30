
CREATE TABLE `geek_text`.`comments` (
  `bookid` INT(11) NOT NULL,
  `userName` VARCHAR(30) NOT NULL,
  `comment` TEXT NULL,
  `anon` INT NOT NULL,
  PRIMARY KEY (`bookid`));

ALTER TABLE `geek_text`.`comments` 
DROP PRIMARY KEY;

ALTER TABLE `geek_text`.`comments` 
CHANGE COLUMN `comment` `comment` TEXT NOT NULL ,
CHANGE COLUMN `anon` `anon` VARCHAR(30) NOT NULL,
ADD COLUMN `score` INT(11) NOT NULL ;

