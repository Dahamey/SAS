*******************************************************************************;
*  Activity 1.03                                                              *;
*    1) View the code. How many steps are in the program? 3                    *;
*    2) How many statements are in the PROC PRINT step?   3  : var, class, run *;
*    3) How many global statements are in the program?   2 : title             *;
*    4) Run the program and view the log.                      *;
*    5) How many observations were read by the PROC PRINT *;
*       step?       11 observations (using LOG)                                *;
***********************************************************;

data mycars;
	set sashelp.cars;
	AvgMPG=mean(mpg_city, mpg_highway);
run;

title "Cars with Average MPG Over 35";
proc print data=mycars;
	var make model type avgmpg;
	where AvgMPG > 35;
run;

/*MAXDEC=1 : display numeric values with a maximum of one decimal place.*/
title "Average MPG by Car Type";
proc means data=mycars mean min max maxdec=1;
	var avgmpg;
	class type;
run;

title;



***********************************************************;
*  Activity 1.04                                          *;
*    1) Format the program to improve the spacing. What   *;
*       syntax error is detected? Fix the error and run   *;
*       the program.                                      *;
*    2) Read the log and identify any additional syntax   *;
*       errors or warnings. Correct the program and       *;
*       format the code again.                            *;
*    3) Add a comment to describe the changes that you    *;
*       made to the program.                              *;
*    4) Run the program and examine the log and results.  *;
*       How many rows are in the canadashoes data?  37 obs      *;
***********************************************************;

/*data canadashoes; set sashelp.shoes;
	where region="Canada;
	Profit=Sales-Returns;run;

prc print data=canadashoes;run;*/


/*My answer*/
data canadashoes;
	set sashelp.shoes;
	where region = "Canada"; 
	Profit=Sales-Returns;
run;

proc print data=canadashoes;
run;


***********************************************************;
*  Viewing Table and Column Attributes                    *;
***********************************************************;
*  Syntax and Example                                     *;
*                                                         *;
*    PROC CONTENTS DATA=data-set;                         *;
*    RUN;                                                 *; 
***********************************************************;

/*My answers*/
proc contents data="/home/u63703188/EPG1V2/data/class_birthdate.sas7bdat";
run;

***********************************************************;
*  Activity 2.04                                          *;
*    1) Write a PROC CONTENTS step to generate a report   *;
*       of the STORM_SUMMARY.SAS7BDAT table properties.   *;
*       Highlight the step and run only the selected      *;
*       code.                                             *;
*    2) How many observations are in the table?  3118         *;
*    3) How is the table sorted?    Alphabetically                      *;
***********************************************************;

/*My answers*/
proc contents data= pg1.STORM_SUMMARY;
run;


***********************************************************;
*  Activity 2.07                                          *;
*  1) If necessary, update the path of the course files   *;
*     in the LIBNAME statement.                           *;
*  2) Complete the PROC CONTENTS step to read the parks   *;
*     table in the NP library.                            *;
*  3) Run the program. Navigate to your list of libraries *;
*     and expand the NP library. Confirm three tables are *;
*     included: Parks, Species, and Visits.               *;
*  4) Examine the log. Which column names were modified   *;
*     to follow SAS naming conventions?                   *;
*  5) Uncomment the final LIBNAME statement and run it to *;
*     clear the NP library.                               *;
***********************************************************;

options validvarname=v7;

*Update the location of the course files if necessary;
libname np xlsx "s:/workshop/data/np_info.xlsx";

proc contents data = ;
run;

*libname np clear;



/*My answers*/

options validvarname = v7;

libname np xlsx "/home/u63703188/EPG1V2/data/np_info.xlsx";

proc contents data = np.parks;
run;

libname np clear;


***********************************************************;
*  Activity 2.08                                          *;
*    1) This program imports a tab-delimited file. Run    *;
*       the program twice and carefully read the log.     *;
*       What is different about the second submission?    *;
*    2) Fix the program and rerun it to confirm that the  *;
*       import is successful.                             *;
***********************************************************;

*Modify the path if necessary;
proc import datafile="s:/workshop/data/storm_damage.tab" 
			dbms=tab out=storm_damage_tab;
run;



/*My answer*/

proc import datafile="/home/u63703188/EPG1V2/data/storm_damage.tab" 
			dbms=tab out=storm_damage_tab;
run;




***********************************************************;
*  Activity 3.02                                          *;
*    1) Uncomment each WHERE statement one at a time and  *;
*       run the step to observe the rows that are         *;
*       included in the results.                          *;
*    2) Comment all previous WHERE statements. Add a new  *;
*       WHERE statement to print storms that begin with   *;
*       Z. How many storms are included in the results? 0  *;
***********************************************************;

proc print data=pg1.storm_summary(obs=50);
	*where MinPressure is missing; /*same as MinPressure = .*/
	*where Type is not missing; /*same as Type ne " "*/
	*where MaxWindMPH between 150 and 155;
	*where Basin like "_I";
run;


/*My answers*/
proc print data = pg1.storm_summary(obs=50);
	where MinPressure is missing /*same as MinPressure = .*/

		and MaxWindMPH between 150 and 155
		and Basin like "_I"
		and name like "Z%";
run;



***********************************************************;
*  Activity 3.03                                          *;
*    1) Change the value in the %LET statement from NA to *;
*       SP.                                               *;
*    2) Run the program and carefully read the log.       *;
*       Which procedure did not produce a report? proc freq     *;
*       What is different about the WHERE statement in    *;
*       that step?                                        *;
***********************************************************;

%let BasinCode=NA;

proc means data=pg1.storm_summary;
	where Basin="&BasinCode";
	var MaxWindMPH MinPressure;
run;

proc freq data=pg1.storm_summary;
	where Basin='&BasinCode';
	tables Type;
run;


/*My answer*/
%let BasinCode=SP;

proc means data=pg1.storm_summary;
	where Basin="&BasinCode";
	var MaxWindMPH MinPressure;
run;

proc freq data=pg1.storm_summary;
	where Basin='&BasinCode';
	tables Type;
run;


***********************************************************;
*  Activity 3.05                                          *;
*    1) Highlight the PROC PRINT step and run the         *;
*       selected code. Notice how the values of Lat, Lon, *;
*       StartDate, and EndDate are displayed in the       *;
*       report.                                           *;
*    2) Change the width of the DATE format to 7 and run  *;
*       the PROC PRINT step. How does the display of      *;
*       StartDate and EndDate change?   DDMMMYY                  *;
*    3) Change the width of the DATE format to 11 and run *;
*       the PROC PRINT step. How does the display of      *;
*       StartDate and EndDate change? DD-MMM-YYYY         *;
*    4) Highlight the PROC FREQ step and run the selected *;
*       code. Notice that the report includes the number  *;
*       of storms for each StartDate.                     *;
*    5) Add a FORMAT statement to apply the MONNAME.      *;
*       format to StartDate and run the PROC FREQ step.   *;
*       How many rows are in the report?   3118 obs               *;
***********************************************************;

proc print data=pg1.storm_summary(obs=20);
	format Lat Lon 4. StartDate EndDate date9.;
run;

proc freq data=pg1.storm_summary order=freq;
	tables StartDate;
	*Add a FORMAT statement;
run;



/*My answers*/
proc print data=pg1.storm_summary(obs=20);
	format Lat Lon 4. StartDate EndDate date11.;
run;

proc freq data= pg1.storm_summary order = freq;
	tables startDAte;
	format StartDate MONNAME.;
run;



***********************************************************;
*  Activity 3.06                                          *;
*    1) Modify the OUT= option in the PROC SORT statement *;
*       to create a temporary table named STORM_SORT.     *;
*    2) Complete the WHERE and BY statements to answer    *;
*       the following question: Which storm in the North  *;
*       Atlantic basin (NA or na) had the strongest       *;
*       MaxWindMPH?                                       *;
***********************************************************;

proc sort data=pg1.storm_summary out=;
	where ;
	by ;
run;


/*My answers*/
proc sort data= pg1.storm_summary out = storm_sort;
	where basin in ("NA", "na");
	by descending  maxwindmph;
run;
