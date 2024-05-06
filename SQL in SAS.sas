

/*SAS amsp supports other programming languages a,d APIs;
SQL (Structured Query Language) is very common and used 
in a wide variety of softwares.

SAS enables us to write SQL code as part of a SAS program*/


PROC SQL;
	SELECT Name, Age, Height, Birthdate FORMAT= date9.
	FROM pg1.class_birthdate;
QUIT;


*Filtering and sorting output;

PROC SQL;
	SELECT Name, Age, Height, Birthdate FORMAT= date9.
	FROM pg1.class_birthdate
	WHERE Age > 14;
QUIT;

/*in a traditional SAS program, if we want to produce a report
in a particular order, we must use a "PROC SORT" to sort the data
and then run the reporting procedure using the sorted data.

However in SQL, we can do it all in one query, by using the 
"ORDER BY" clause :*/
PROC SQL;
	SELECT Name, Age, Height, Birthdate FORMAT= date9.
	FROM pg1.class_birthdate
	WHERE Age > 14
	ORDER BY Height desc, Name;
QUIT;


*Creating a new table (in this example, we create 
a table in the work library);
PROC SQL;
	CREATE TABLE Work.myclass as
		SELECT NAme, Age, Height
		FROM pg1.class_birthdate
		WHERE Age > 14
		ORDER BY Height desc;
QUIT;


*Deleting Table (dropping the table we just created);
PROC SQL;
	DROP TABLE Work.myclass;
QUIT;

*Creating Inner joins in SQL;
PROC SQL;
	SELECT cu.Name, Grade, Age, Teacher
	FROM pg1.class_update cu INNER JOIN pg1.class_teachers ct
		on cu.Name = ct.Name;
RUN;
	
QUIT;


