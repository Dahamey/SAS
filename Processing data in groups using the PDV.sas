/*Examining the contents of the PDV during execution*/
data storm_complete;
	set pg2.storm_summary_small(obs=2);
	PUTLOG "NOTE: PDV after SET statement";
	putlog _all_;
RUN;


/*Creating an accumulating column 'YTDRRAIN'*/
* Method 1;
data houston2017;
	set pg2.weather_houston;
	RETAIN YTDRRAIN 0;
	YTDRRAIN = YTDRRAIN + DailyRain;
RUN;

* Method 2;
data houston2017;
	set pg2.weather_houston;
	YTDRRAIN + DailyRain;
RUN;


/*Processing data in groups*/
* Using one BY column:

*1) First, we create a sorted table by the column that has the groups we want to analyze;
PROC SORT DATA= pg2.storm_2017 OUT= storm_2017_sorted;
	BY Basin;
RUN;

*2) Then, we use the same BYcolumn (BYcol) in the DATA step to tell SAS we want to process
data in groups, when a DATA step includes a BYcolumn, 2 special (temporarly) columns 
'First.BYcol' and 'Last.BYcol' are added to the PDV (we can take a look the LOG);
DATA storm_2017_max;
	SET storm_2017_sorted(obs=2);
	BY Basin;
	PUTLOG "NOTE: PDV after SET statement";
	putlog _all_;
RUN;

DATA storm_2017_max;
	SET storm_2017_sorted;
	BY Basin;
RUN;

DATA storm_2017_max;
	SET storm_2017_sorted(keep = Basin Name);
	BY Basin;
	First_Basin = FIRST.Basin;
	Last_Basin = LAST.Basin;
RUN;


/*Subsettinjg rows in the execution phase :
Since first.BYcol and last.BYcol are not variables in the input table
instead of using 'WHERE' (works only on variables of the input table)
we use the subsetting IF statement*/

PROC SORT DATA=pg2.storm_2017 out= storm_2017_sort;
	BY Basin MaxWindMPH;
RUN;

DATA sotrm2017_max;
	SET storm_2017_sorted;
	BY Basin;
	IF last.basin = 1; *taking only the last row in each Basin group;
	StormLength = EndDate - StartDate;
	MaxWindKmph = MaxWindMPH *1.60934;
RUN;

* Using multiple Bycolumns;
DATA sydney_summary;
	SET pg2.weather_sydney(obs=2);
	BY Year Qtr;
	PUTLOG _ALL_;
RUN;

DATA sydney_summary;
	SET pg2.weather_sydney;
	BY Year Qtr;
	first_Year = first.Year;
	last_Year = Last.Year;
	first_qtr = first.qtr;
	last_qtr = last.qtr;
RUN;

/*The "First./Last." variables for the quarter represent when a value for 
quarter begins and ends WITHIN A PARTICULAR YEAR*/	


