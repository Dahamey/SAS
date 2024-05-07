/*Restructing Data with the DATA step*/

* Converting a wide table to a narrow table;

DATA class_test_narrow;
	SET PG2.class_test_wide;
	KEEP Name TestSubject TestScore;
	LENGTH TestSubject $ 7; *initializing the length of the shubject column;
	TestSubject = "Math";
	TestScore = Math;
	output;  *output the 'Math' row;
	TestSubject = "Reading";
	TestScore = Reading;
	output; *output the 'Reading' row;
RUN;


* Converting a narrow table to a wide table;
DATA class_wide;
	SET pg2.class_test_narrow;
	BY Name;  *To use the last.Name temporary variable later to output the row associated with each Name;
	RETAIN Name Math Reading; *Holds values in the PDV across multiple iterations of the DATA step;
	KEEP Name Math Reading;
	IF TestSubject = "Math" THEN Math = TestScore;
	ELSE IF TestSubject = "Reading" THEN Reading = TestScore;
	IF Last.Name = 1 THEN output;
RUN;




/*Restructing Data with the TRANSPOSE procedure*/

***********************************************************;
*  Creating a Split Table with PROC TRANSPOSE             *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    PROC TRANSPOSE DATA=input-table OUT=output-table     *;
*                   <PREFIX=column> <NAME=column>;        *;
*        <VAR columns(s)>;                                *;
*        <ID column>;                                     *;
*        <BY column(s)>;                                  *;
*    RUN;                                                 *;
***********************************************************;

* The input-table must be sorted before by the same BYcol we're going to use in the
TRANSPOSE procedure;

* Converting a wide table to a narrow table;
PROC TRANSPOSE DATA=pg2.storm_top4_wide OUT= storm_top4_narrow(rename=(COL1 = speed))
	NAME = Wind ; *renaming the '_NAME_' column to 'Wind';
	BY Season Basin Name;
	VAR Wind1 WInd2; *Transposing only wind1 and wind2;
RUN;

* Converting a narrow table to a wide table;
PROC TRANSPOSE DATA = pg2.np_2016camping OUT=camping2016_transposed;
	BY ParkName;
	ID CampType;
	VAR CampCount;
RUN;
	