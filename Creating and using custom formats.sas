/*Creating and using custom formats*/

*SAS supplies over 100 formats for us to use, however sometimes, we can'y find one that
meets our needs. The FORMAT procedure enables us to create our own custom formats;
* other, low, high are keywords of SAS;
* [a,b]---> a-b;
* [a,b[---> a-<b;
* ]a,b] ---> a<-b;


PROC FORMAT;
VALUE $regfmt "C" = "Complete"    /*$ because it's a char format*/
			  "I" = "Incomplete"
			  other = "Micscoded";
			  
VALUE hrange low-<58 = "Below Average"   /*[low, 58[*/
			 58-60 = "Average"           /*[58,60]*/
			 60<-high = "Above Average"; /*]60, high]*/
RUN;

/*Before formatting*/
PROC PRINT DATA= pg2.class_birthdate;
RUN;

/*After formatting the column 'Registration' column */
PROC PRINT DATA=pg2.class_birthdate;
	FORMAT Registration $regfmt.;
RUN;

/*Using ranges to format the 'Height'column */
PROC PRINT DATA=pg2.class_birthdate;
	FORMAT Height hrange.;
RUN;



/*Creating custom formats from tables*/
*To do that we need at least 3 columns : 1 for fomat's names, 1 for start, and 1 for label;  
* Step1: we build the table;
DATA sbdata;
	RETAIN FmtName "$sbfmt";
	SET pg2.storm_subbasincodes(rename=(Sub_Basin = Start
										SubBasin_Name = Label));
	KEEP Start Label FmtName;
RUN;

*Step2: instead of using 'VALUE' we use 'CNTLIN' to create the new custom format;
PROC FORMAT CNTLIN=sbdata;
RUN;
