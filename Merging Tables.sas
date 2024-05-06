/*Handling column attributes*/
* When multiple tables are listed in the SET statement, columns from the first 
tables are added to the PDV with their corresponding attributes (length, format...).
When SAS reads the second table in the SET statement, the attributes of any columns
that are already in the PDV cannot be changed. We can solve this problem by using the
LENGTH statement, for example to deal with the difference of length in the matching columns
Name(length 8) and Student(length 9);

DATA class_current;
	LENGTH NAME $ 9;
	SET SASHELP.class
		pg2.class_new2(rename=(Student = Name));
RUN;

/*What is merge ?*/
*Merging or joining tables is necessary when we want to combine columns from multiple
tables into a single table. There are different ways to accomplish this in SAS;

*1) PROC SQL : "https://github.com/Dahamey/SAS/blob/main/SQL%20in%20SAS.sas";
*2) DATA step :  There are seveveral scenarios that could arise :
  i) one-to-one merge : Each row in one table matches a single row in the other table.
  ii) one-to-many merge : Each row from one table matches with one or more rows in the other table
  iii) npn matches merge : rows from one table don't have a match in the other table
Each of these scenarios can be handled with the DATA step MERGE;

*Processing a One-to-One merges 
Step1: Sorting the tables;
PROC SORT DATA = SASHELP.CLASS OUT = CLASS_sorted;
	BY Name;
RUN;
PROC SORT DATA = PG2.class_teachers OUT = class_teachers_sorted;
	BY Name;
RUN;
*Step2: Merge;
DATA class_merged;
	MERGE  CLASS_sorted class_teachers_sorted;
	BY  Name;
RUN;

*Processing a One-to-Many merges 
Step1: Sorting the tables;
PROC SORT DATA = pg2.class_test2 OUT = class_test2_sorted;
	BY Name;
RUN;

*Step2: Merge;
DATA class2_merged;
	MERGE class_teachers_sorted class_test2_sorted;
	BY Name;
RUN;

***********************************************************;
*  Merging Tables with Non-matching Rows                  *;
***********************************************************;
*  Syntax and Examples                                    *;
*                                                         *;
*    DATA output-table;                                   *;
*        MERGE input-table1(IN=variable1)                 *;
*              input-table2(IN=variable2) ...;            *;
*        BY by-variable;                                  *;
*        IF expression;                                   *;
*    RUN;                                                 *;
***********************************************************;

/*Include matching rows only*/
data class2;
    merge pg2.class_update(in=inUpdate) 
          pg2.class_teachers(in=inTeachers);
    by name;
    if inUpdate=1 and inTeachers=1;
run;


/*Merging Tables with matching column names*/
* To merge both tables we need to rename each colomn; 
DATA weather_sanfran;
	MERGE  PG2.WEATHER_SANFRAN2016(rename=(AvgTemp = AvgTemp2016))
		   PG2.WEATHER_SANFRAN2017(rename=(AvgTemp = AvgTemp2017));
	BY month;
RUN;

/*Joining 3 or more tables without a common column is one task
that is much easier to accomplish by using a PROC SQL step*/
PROC SQL;
	CREATE TABLE class_combine as 
	SELECT u.*, t.Grade, t.teacher, r.room
	FROM pg2.class_update as u
	INNER JOIN pg2.class_teachers as t 
		ON u.Name = t.Name
	INNER JOIN pg2.class_rooms as r 
		ON t.teacher = r.teacher;
QUIT;
QUIT;
