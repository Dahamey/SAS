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

***********************************************************;
*  Activity 4.03                                          *;
*    1) Change the name of the output table to            *;
*       STORM_CAT5.                                       *;
*    2) Include only Category 5 storms (MaxWindMPH        *;
*       greater than or equal to 156) with StartDate on   *;
*       or after 01JAN2000.                               *;
*    3) Add a statement to include the following columns  *;
*       in the output data: Season, Basin, Name, Type,    *;
*       and MaxWindMPH. How many Category 5 storms        *;
*       occurred since January 1, 2000?    18               *;
***********************************************************;

* if necessary, change the path to your output folder *;
libname out "s:/workshop/output";

data out.storm_new;
    set pg1.storm_summary;
run;


/*My answers*/

libname out "/home/u63703188/EPG1V2/output";

data out.STORM_CAT5;
    set pg1.storm_summary;
    keep Season Basin Name Type MaxWindMPH;
    where MaxWindMPH >= 156 and StartDate >= "01JAN2000"d;
run;

***********************************************************;
*  Activity 4.04                                          *;
*    1) Add an assignment statement to create StormLength *;
*       that represents the number of days between        *;
*       StartDate and EndDate.                            *;
*    2) Run the program. In 1980, how long did the storm  *;
*       named Agatha last?                                *;
***********************************************************;

data storm_length;
	set pg1.storm_summary;
	drop Hem_EW Hem_NS Lat Lon;
	*Add assignment statement;
run;


/*My answers*/
data storm_length; /*this table will be in work library*/
	set pg1.storm_summary;
	drop Hem_EW Hem_NS Lat Lon;
	StormLength = intck("day", StartDate, EndDate);
run;

***********************************************************;
*  Activity 4.05                                          *;
*    1) Open the PG1.STORM_RANGE table and examine the    *;
*       columns. Notice that each storm has four wind     *;
*       speed measurements.                               *;
*    2) Create a new column named WindAvg that is the     *;
*       mean of Wind1, Wind2, Wind3, and Wind4.           *;
*    3) Create a new column WindRange that is the range   *;
*       of Wind1, Wind2, Wind3, and Wind4.                *;
***********************************************************;

data storm_wingavg;
	set pg1.storm_range;
	*Add assignment statements;
run;


/*My answers*/

proc print data=pg1.STORM_RANGE;
run;

data storm_wingavg;
	set pg1.storm_range;
	WindAvg = mean(Wind1, Wind2, Wind3, Wind4);
	WindRange = range(of Wind1-Wind4);
run;

***********************************************************;
*  Activity 4.06                                          *;
*    1) Add a WHERE statement that uses the SUBSTR        *;
*       function to include rows where the second letter  *;
*       of Basin is P (Pacific ocean storms).             *;
*    2) Run the program and view the log and data. How    *;
*       many storms were in the Pacific basin?    1958         *;
***********************************************************;
*  Syntax                                                 *;
*     SUBSTR (char, position, <length>)                   *;
***********************************************************;

data pacific;
	set pg1.storm_summary;
	drop Type Hem_EW Hem_NS MinPressure Lat Lon;
	*Add a WHERE statement that uses the SUBSTR function;
run;

/*My answers*/
data pacific;
	set pg1.storm_summary;
	drop Type Hem_EW Hem_NS MinPressure Lat Lon;
	where substr(Basin, 2,1) in ("p", "P");
run;

***********************************************************;
*  Activity 4.07                                          *;
*    1) Add the ELSE keyword to test conditions           *;
*       sequentially until a true condition is met.       *;
*    2) Change the final IF-THEN statement to an ELSE     *;
*       statement.                                        *;
*    3) How many storms are in PressureGroup 1?     385      *;
***********************************************************;

data storm_cat;
	set pg1.storm_summary;
	keep Name Basin MinPressure StartDate PressureGroup;
	*add ELSE keyword and remove final condition;
	if MinPressure=. then PressureGroup=.;
	if MinPressure<=920 then PressureGroup=1;
	if MinPressure>920 then PressureGroup=0;
run;

proc freq data=storm_cat;
	tables PressureGroup;
run;

/*My answers*/
data storm_cat;
	set pg1.storm_summary;
	keep Name Basin MinPressure StartDate PressureGroup;
	*add ELSE keyword and remove final condition;
	if MinPressure=. then PressureGroup=.;
    else if MinPressure<=920 then PressureGroup=1;
	else PressureGroup=0;
run;

proc freq data=storm_cat;
	tables PressureGroup;
run;



***********************************************************;
*  Activity 4.08                                          *;
*    1) Run the program and examine the results. Why is   *;
*       Ocean truncated? What value is assigned when      *;
*       Basin='na'?                                       *;
*    2) Modify the program to add a LENGTH statement to   *;
*       declare the name, type, and length of Ocean       *;
*       before the column is created.                     *;
*    3) Add an assignment statement after the KEEP        *;
*       statement to convert Basin to uppercase. Run the  *;
*       program.                                          *;
*    4) Move the LENGTH statement to the end of the DATA  *;
*       step. Run the program. Does it matter where the   *;
*       LENGTH statement is in the DATA step? yes            *;
***********************************************************;
*  Syntax                                                 *;
*       LENGTH char-column $ length;                      *;
***********************************************************;

data storm_summary2;
	set pg1.storm_summary;
	*Add a LENGTH statement;
	keep Basin Season Name MaxWindMPH Ocean;
	*Add assignment statement;
	OceanCode=substr(Basin,2,1);
	if OceanCode="I" then Ocean="Indian";
	else if OceanCode="A" then Ocean="Atlantic";
	else Ocean="Pacific";
run;


/*My answers*/
data storm_summary2;
	set pg1.storm_summary;
	length Ocean  $ 10;
	keep Basin Season Name MaxWindMPH Ocean;
	Basin = upcase(Basin);
	OceanCode=substr(Basin,2,1);
	if OceanCode="I" then Ocean="Indian";
	else if OceanCode="A" then Ocean="Atlantic";
	else Ocean="Pacific";
run;


***********************************************************;
*  Activity 4.09                                          *;
*    Run the program. Why does the program fail?          *;
***********************************************************;

data front rear;
    set sashelp.cars;
    if DriveTrain="Front" then do;
        DriveTrain="FWD";
        output front;
    else if DriveTrain='Rear' then do;
        DriveTrain="RWD";
        output rear;
run;

/*My asnwers : wrong grammar "END"*/
data front rear;
    set sashelp.cars;
    if DriveTrain="Front" then do;
        DriveTrain="FWD";
        output front;
    end;
    else if DriveTrain='Rear' then do;
        DriveTrain="RWD";
        output rear;
    end;
run;

***********************************************************;
*  Activity 5.01                                          *;
*    1) In the program, notice that there is a TITLE      *;
*       statement followed by two procedures. Run the     *;
*       program. Where does the title appear in the       *;
*       output?      above both reports                                     *;
*    2) Add a TITLE2 statement above PROC MEANS to print  *;
*       a second line:                                    *;
*       Summary Statistics for MaxWind and MinPressure    *;
*    3) Add another TITLE2 statement above PROC FREQ with *;
*       this title: Frequency Report for Basin            *;
*    4) Run the program. Which titles appear above each   *;
*       report?                                           *;
***********************************************************;

title "Storm Analysis";

proc means data=pg1.storm_final;
	var MaxWindMPH MinPressure;
run;

proc freq data=pg1.storm_final;
	tables BasinName;
run;


/*My answers*/
title "Storm Analysis";
title2 "Summary Statistics for MaxWind and MinPressure";

proc means data=pg1.storm_final;
	var MaxWindMPH MinPressure;
run;

title2 "Frequency Report for Basin";
proc freq data=pg1.storm_final;
	tables BasinName;
run;

***********************************************************;
*  Activity 5.02                                          *;
*       Notice that there are no TITLE statements in the  *;
*       code. Run the program. Does the report have       *;
*       titles?                                           *;
***********************************************************;

proc means data=sashelp.heart;
	var height weight;
run;


***********************************************************;
*  Activity 5.03                                          *;
*    1) Modify the LABEL statement in the DATA step to    *;
*       label the Invoice column as Invoice Price.        *;
*    2) Run the program. Why do the labels appear in the  *;
*       PROC MEANS report but not in the PROC PRINT       *;
*       report? Fix the program and run it again.         *;
***********************************************************;

data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon";
run;

proc means data=cars_update min mean max;
    var MSRP Invoice;
run;

proc print data=cars_update;
    var Make Model MSRP Invoice AvgMPG;
run;



/*My answers*/
data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon"
          Invoice = "Invoice Price";
run;

proc contents data=cars_update;
run;

proc means data=cars_update min mean max;
    var MSRP Invoice;
run;

proc print data=cars_update;
    var Make Model MSRP Invoice AvgMPG;
run;

***********************************************************;
*  Activity 5.04                                          *;
*    1) Create a temporary output table named storm_count *;
*       by completing the OUT= option in the TABLES       *;
*       statement.                                        *;
*    2) Add the NOPRINT option on the PROC FREQ statement *;
*       to suppress the printed report.                   *;
*    3) Run the program. Which statistics are included in *;
*       the output table? Which month has the highest     *;
*       number of storms?         count and percentage ---> September   *;
***********************************************************;

title "Frequency Report for Basin and Storm Month";

proc freq data=pg1.storm_final order=freq;
	tables StartDate / out= ;
	format StartDate monname.;
run;

/*My answers*/
title "Frequency Report for Basin and Storm Month";

proc freq data=pg1.storm_final order=freq noprint;
	tables StartDate / out= storm_count;
	format StartDate monname.;
run;


***********************************************************;
*  Activity 5.05                                          *;
*    1) Add options to include N (count), MEAN, and MIN   *;
*       statistics. Round each statistic to the nearest   *;
*       integer.                                          *;
*    2) Add a CLASS statement to group the data by Season *;
*       and Ocean. Run the program.                       *;
*    3) Modify the program to add the WAYS statement so   *;
*       that separate reports are created for Season and  *;
*       Ocean statistics. Run the program.                *;
*       Which ocean had the lowest mean for minimum       *;
*       pressure?  Pacific                                        *;
*       Which season had the lowest mean for minimum      *;
*       pressure?  2015                                      *;
***********************************************************;

proc means data=pg1.storm_final;
	var MinPressure;
	where Season >=2010;
run;


/*My answers*/

proc means data=pg1.storm_final n mean min ;
	var MinPressure;
	where Season >=2010;
	class Season Ocean;
	ways 1;
run;

***********************************************************;
*  Activity 5.06                                          *;
*    1) Run the PROC MEANS step and compare the report    *;
*       and the wind_stats table. Are the same statistics *;
*       in the report and table? What do the first five   *;
*       rows in the table represent?                      *;
*    2) Uncomment the WAYS statement. Delete the          *;
*       statistics listed in the PROC MEANS statement and *;
*       add the NOPRINT option. Run the program. Notice   *;
*       that a report is not generated and the first five *;
*       rows from the previous table are excluded.        *;
*    3) Add the following options in the OUTPUT statement *;
*       and run the program again. How many rows are in   *;
*       the output table?                                 *;
*         output out=wind_stats mean=AvgWind max=MaxWind; *;
***********************************************************;

proc means data=pg1.storm_final mean median max;
	var MaxWindMPH;
	class BasinName;
	*ways 1;
	output out=wind_stats;
run;

/*My asnwers*/
proc means data=pg1.storm_final noprint;
	var MaxWindMPH;
	class BasinName;
	ways 1;
	output out=wind_stats mean = Avgwind max = MaxWind;
run;


**************************************************;
*  Activity 5.07                                 *;
*    Run the program and examine the results to  *;
*    see examples of other procedures that       *;
*    analyze and report on the data.             *;
**************************************************;

%let Year=2016;
%let basin=NA;

**************************************************;
*  Creating a Map with PROC SGMAP                *;
*   Requires SAS 9.4M5 or later                  *;
**************************************************;

*Preparing the data for map labels;
data map;
	set pg1.storm_final;
	length maplabel $ 20;
	where season=&year and basin="&basin";
	if maxwindmph<100 then MapLabel=" ";
	else maplabel=cats(name,"-",maxwindmph,"mph");
	keep lat lon maplabel maxwindmph;
run;

*Creating the map;
title1 "Tropical Storms in &year Season";
title2 "Basin=&basin";
footnote1 "Storms with MaxWind>100mph are labeled";

proc sgmap plotdata=map;
    *openstreetmap;
    esrimap url='https://services.arcgisonline.com/arcgis/rest/services/World_Physical_Map';
            bubble x=lon y=lat size=maxwindmph / datalabel=maplabel datalabelattrs=(color=red size=8);
run;
title;footnote;

**************************************************;
*  Creating a Bar Chart with PROC SGPLOT         *;
**************************************************;
title "Number of Storms in &year";
proc sgplot data=pg1.storm_final;
	where season=&year;
	vbar BasinName / datalabel dataskin=matte categoryorder=respdesc;
	xaxis label="Basin";
	yaxis label="Number of Storms";
run;

**************************************************;
*  Creating a Line PLOT with PROC SGPLOT         *;
**************************************************;
title "Number of Storms By Season Since 2010";
proc sgplot data=pg1.storm_final;
	where Season>=2010;
	vline Season / group=BasinName lineattrs=(thickness=2);
	yaxis label="Number of Storms";
	xaxis label="Basin";
run;

**************************************************;
*  Creating a Report with PROC TABULATE          *;
**************************************************;

proc format;
    value count 25-high="lightsalmon";
    value maxwind 90-high="lightblue";
run;

title "Storm Summary since 2000";
footnote1 "Storm Counts 25+ Highlighted";
footnote2 "Max Wind 90+ Highlighted";

proc tabulate data=pg1.storm_final format=comma5.;
	where Season>=2000;
	var MaxWindMPH;
	class BasinName;
	class Season;
	table Season={label=""} all={label="Total"}*{style={background=white}},
		BasinName={LABEL="Basin"}*(MaxWindMPH={label=" "}*N={label="Number of Storms"}*{style={background=count.}} 
		MaxWindMPH={label=" "}*Mean={label="Average Max Wind"}*{style={background=maxwind.}}) 
		ALL={label="Total"  style={vjust=b}}*(MaxWindMPH={label=" "}*N={label="Number of Storms"} 
		MaxWindMPH={label=" "}*Mean={label="Average Max Wind"})/style_precedence=row;
run;
title;
footnote;


***********************************************************;
*  Activity 6.02                                          *;
*    1) Complete the PROC EXPORT step to read the         *;
*       PG1.STORM_FINAL SAS table and create a            *;
*       comma-delimited file named STORM_FINAL.CSV. Use   *;
*       &outpath to substitute the path of the output     *;
*       folder.                                           *;
*    2) Run the program and view the text file:           *;
*                                                         *;
*       SAS Studio - Navigate to the output folder in the *;
*       Navigation pane, right-click on storm_final.csv,  *;
*       and select View File as Text.                     *;
*                                                         *;
*       Enterprise Guide - Select Open -> Navigate to the *;
*       output folder in the Servers pane, right click    *;
*       storm_final.csv and select Open.                  *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    PROC EXPORT DATA=input-table                         *;
*                OUTFILE="output-file"                    *;
*                <DBMS=identifier> <REPLACE>;             *;
*    RUN;                                                 *; 
***********************************************************;

proc export;
run;  

/*My answers*/

proc export data= PG1.STORM_FINAL outfile = "&outpath/storm_final.csv"
	DBMS = CSV replace;
run;


***********************************************************;
*  Activity 6.03                                          *;
*    1) Complete the LIBNAME statement using the XLSX     *;
*       engine to create an Excel workbook named          *;
*       storm.xlsx in the output folder.                  *;
*    2) Modify the DATA step to write the storm_final     *;
*       table to the storm.xlsx file.                     *;
*    3) After the DATA step, write a statement to clear   *;
*       the library.                                      *;
*    4) Run the program and view the log to confirm that  *;
*       storm.xlsx was exported with 3092 rows.           *;
*    5) If possible, open the storm.xlsx file. How do     *;
*       dates appear in the storm_final workbook?         *;
***********************************************************;
*  Syntax                                                 *;
*    LIBNAME libref xlsx "path/file.xlsx";                *;
*     <use libref for output table(s)>                    *;
*    LIBNAME libref CLEAR;                                *; 
***********************************************************;

libname xl_lib ;

data storm_final;
	set pg1.storm_final;
	drop Lat Lon Basin OceanCode;
run;

/*My answers*/
libname xl_lib xlsx "&outpath/storm.xlsx";

data xl_lib.storm;
	set pg1.storm_final;
	drop Lat Lon Basin OceanCode;
run;

libname xl_lib clear;

***********************************************************;
*  Activity 6.04                                          *;
*    1) Add ODS statements to create an Excel file named  *;
*       pressure.xlsx in the output folder. Be sure to    *;
*       close the ODS location at the end of the program. *;
*       Run the program and open the Excel file.          *;
*       * SAS Studio: Navigate to the output folder in    *;
*       the Files and Folders section of the navigation   *;
*       pane. Select pressure.xlsx and click Download.    *;
*       * Enterprise Guide: Click the Results - Excel tab *;
*       and click Download.                               *;
*    2) Add the STYLE=ANALYSIS option in the first ODS    *;
*       EXCEL statement. Run the program again and open   *;
*       the Excel file.                                   *;
***********************************************************;

*Add ODS statement;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

*Add ODS statement;

ods proctitle;



/*My answers*/

ods excel file = "&outpath/pressure.xlsx";

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods excel close;

ods proctitle;

***********************************************************;
*  Activity 6.05                                          *;
*    1) Run the program and open the pressure.pptx file.  *;
*    2) Modify the ODS statements to change the output    *;
*       destination to RTF. Change the style to sapphire. *;
*    3) Run the program and open the pressure.rtf file.   *;
*    4) Add the STARTPAGE=NO option in the first ODS RTF  *;
*       statement to eliminate the page break.            *;
*    5) Rerun the program and examine the results in      *;
*       Microsoft Word.                                   *;
***********************************************************;

ods powerpoint file="&outpath/pressure.pptx" style=powerpointlight;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods powerpoint close;

/*My answers*/
ods RTF file="&outpath/pressure.rtf" style=sapphire STARTPAGE=NO;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods RTF close;

***********************************************************;
*  Activity 7.01                                          *;
*    1) What are the similarities and differences in the  *;
*       syntax of the two steps?                          *;
*    2) Run the program. What are the similarities and    *;
*       differences in the results?                       *;
***********************************************************;

title "PROC PRINT Output";
proc print data=pg1.class_birthdate;
	var Name Age Height Birthdate;
	format Birthdate date9.;
run;

title "PROC SQL Output";
proc sql;
select Name, Age, Height*2.54 as HeightCM format=5.1, Birthdate format=date9.
    from pg1.class_birthdate;
quit;

title;

***********************************************************;
*  Activity 7.02                                          *;
*    1) Complete the SQL query to display Event and Cost  *;
*       from PG1.STORM_DAMAGE. Format the values of Cost. *;
*    2) Add a new column named Season that extracts the   *;
*       year from Date.                                   *;
*    3) Add a WHERE clause to return rows where Cost is   *;
*       greater than 25 billion.                          *;
*    4) Add an ORDER BY clause to arrange rows by         *;
*       descending Cost. Which storm had the highest      *;
*       cost?      Hurricane Katrina                                   *;
***********************************************************;
*  Syntax                                                 *;
*    PROC SQL;                                            *;
*        SELECT col-name, col-name FORMAT=fmt             *;
*        FROM input-table                                 *;
*        WHERE expression                                 *;
*        ORDER BY col-name <DESC>;                        *;
*    QUIT;                                                *;
*                                                         *;
*    New column in SELECT list:                           *;
*    expression AS col-name                               *;
***********************************************************;

title "Most Costly Storms";
proc sql;
*Add a SELECT statment;
quit;



/*My Answers*/
title "Most Costly Storms";
proc sql;
	select Event  , Cost
	from PG1.STORM_DAMAGE
	where cost >= 25e9
	order by cost desc ;
	
quit;

***********************************************************;
*  Activity 7.03                                          *;
*    1) Define aliases for STORM_SUMMARY and              *;
*       STORM_BASINCODES in the FROM clause.              *;
*    2) Use one table alias to qualify Basin in the       *;
*       SELECT clause.                                    *;
*    3) Complete the ON expression to match rows when     *;
*       Basin is equal in the two tables. Use the table   *;
*       aliases to qualify Basin in the expression. Run   *;
*       the step.                                         *;
***********************************************************;
*  Syntax                                                 *;
*     FROM table1 AS alias1 INNER JOIN table2 AS alias2   *;
*     ON alias1.column = alias2.column                    *;
***********************************************************;

proc sql;
select Season, Name, storm_summary.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary inner join pg1.storm_basincodes
		on  
    order by Season desc, Name;
quit;


/*My answers*/


proc sql;
select Season, Name, ss.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary ss inner join pg1.storm_basincodes sb
		on  ss.Basin = sb.Basin
    order by Season desc, Name;
quit;







