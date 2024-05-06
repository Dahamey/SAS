/*Using Numeric and Date Functions*/

* Numeric functios;
DATA quiz_analysis;
	*Generating random 4 digits integers (i.e between 1000 and 9999) to assign them to each student;
	StudentID = RAND("integer", 1000, 9999);
	* 'StudentID' is defined before the SET statement because we want the ID to be the first column;
	SET pg2.class_quiz;
	DROP Quiz1-Quiz5 name;
	Quiz1st = LARGEST(1, of Quiz1-QUiz5); *The highest grade for each student (ie. in each row);
	Quiz2nd = LARGEST(2, of Quiz1-Quiz5); *The second highest grade for each student (ie. in each row);
	Quiz3rd = LARGEST(3, of Quiz1-Quiz5); *The third highest grade for each student (ie. in each row);
	Top3Avg_rounded = ROUND(MEAN(of Quiz1st--Quiz3rd), .1); * 1 decimal;
	Top3Avg_ceiled = CEIL(MEAN(of Quiz1st--Quiz3rd));
	Top3Avg_floored = FLOOR(MEAN(of Quiz1st--Quiz3rd));
	Top3Avg_INT = INT(MEAN(of Quiz1st--Quiz3rd)); *Integer value;
RUN;


/*SAS Date, SAS Datetime, SAS Time Values :
SAS Date : number of days since 01Jan1960 ([0, +inf[)
SAS Time :  number of seconds since midnight 00:00 ([0, +inf[)
SAS Datetime : number of seconds from midnight on 01Jan1960 (]-inf, +inf[)*/

*Calculating Date intervals;
DATA storm_summary2;
	SET pg2.storm_summary;
	DaysNumber = INTCK("day", StartDate, EndDate);  *How many days did the storm last?;
	WeeksNumber_d = INTCK("week", StartDate, EndDate) ; *counting weeks jn a discrete manner: 1 week is Sunday-Saturday;
	WeeksNumber_c = INTCK("week", StartDate, EndDate, "c");  *counting weeks jn a continuous manner : 1 week is 7 completed days;
RUN;


*Shifting Date values;
DATA storm_damage2;
	SET pg2.storm_damage;
	KEEP Event Date AssessmentDate Anniversary;
	* Date of the 15th ('middle') of the month before (-1 means one interval unit before);
	AssessmentDate = INTNX("month", Date, -1, "middle");
	* 10 year anniversary of each storm;
	Anniversary = INTNX("year", Date, 10, "same");
	FORMAT _numeric_ date9.;
RUN;


* Character functions : check out ;
