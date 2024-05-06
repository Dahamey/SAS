/*outputing a statitics summary table*/
proc means data=sashelp.heart noprint;
	var weight;
	class chol_status;
	ways 1;
	output out = heart_stats mean = AvgWeight;
run;


/*Cross-tabulation (2-way Frequency report)*/
PROC FREQ DATA=sashelp.heart;
	tables sex * BP_status;
run;


/*Summary Reports and data*/
PROC MEANS DATA=sashelp.heart;
	var cholesterol;
	class sex;
	ways 1;
run;

/*Exporting the last report to a CSV file*/
ODS CSVALL FILE="/home/u63703188/MyPersonalFolder/cholesterol_report.csv";
PROC MEANS DATA=sashelp.heart;
	var cholesterol;
	class sex;
	ways 1;
run;
ODS CSVALL CLOSE;

/*View different styles */
PROC TEMPLATE;
	list styles;
RUN;

/*Creating an excel file with 2 worksheets*/
*1st worksheet;
ODS EXCEL FILE= "/home/u63703188/MyPersonalFolder/wind.xlsx" STYLE = SasDocPrinter
	OPTIONS(SHEET_NAME = "Wind Stats");
TITLE "Wind Statistics By Basin";
ODS NOPROCTITLE;
PROC MEANS DATA=pg1.storm_final min max mean median maxdec=0;
	class BasinName;
	var MaxWindMPH;
RUN;

*2nd worksheet;
ODS EXCEL OPTIONS(SHEET_NAME="Wind Distribution");
Title "Distribution of Maximum Wind";
PROC SGPLOT DATA=pg1.storm_final;
	HISTOGRAM MaxWindMPH;
	DENSITY MaxWindMPH;
RUN;
TITLE;
ODS PROCTITLE;

ODS EXCEL CLOSE;