/*EXAMPLE 1*/

/*The PROC TTEST step analyzes the SalePrice variable. The H0= option specifies
 our null hypothesis value of 135,000. The INTERVAL option requests confidence
 interval plots for the means, and the SHOWNULL option displays a vertical 
 reference line at the null value of 135,000.*/


ODS graphics;

ODS PDF FILE ="/home/u63703188/My Personal statistic Folder/Example 1 : One-Sample t-test.pdf" STYLE=sapphire STARTPAGE=NO;
PROC TTEST data= STAT1.ameshousing3
			plots(shownull) = interval
			H0 = 135000;  
	 VAR SalePrice;
	 TITLE "One-Sample t-test testing whether mean SalePrice = $135,000";
RUN;

title;
ODS PDF CLOSE;


/*Based on the t test results, we can assume that the Students t test is valid,
 and we can conclude that the mean sale price of homes in Ames, Iowa, is not
 statistically different from $135,000.*/








/*EXAMPLE 2*/

/*The data in stat1.normtemp come from an article in the Journal of Statistics
 Education by Dr. Allen L. Shoemaker from the Psychology Department at Calvin College.
 The data are based on an article in a 1992 edition of JAMA (Journal of the American 
 Medical Association). The notion that the true mean body temperature is 98.6 is questioned.
 There are 65 males and 65 females. There is also some doubt about whether mean body
 temperatures for women are the same as for men.*/

*1) Look at the distribution of the continuous variables in the stat1.normtemp data set.
Use PROC UNIVARIATE to produce histograms and insets with means, standard deviations, and
 sample size;
ODS PDF FILE ="/home/u63703188/My Personal statistic Folder/Example2 : One-Sample t-test.pdf" STYLE=sapphire STARTPAGE=NO;

%let interval=BodyTemp HeartRate; 
ODS GRAPHICS; 
ODS SELECT histogram; 


PROC UNIVARIATE data= stat1.normtemp ;
	VAR  &interval;
	HISTOGRAM &interval / NORMAL KERNEL;
	INSET n mean std / POSITION = ne;
	TITLE "Interval Variable Distribution Analysis";
RUN;

*2) Perform a one-sample t test to determine whether the mean of body temperatures is 98.6.
 Produce a confidence interval plot of BodyTemp. Use the value 98.6 as a reference;

PROC TTEST DATA= STAT1.normtemp PLOTS(shownull) = interval H0 = 98.6;
	VAR BodyTemp;
	TITLE "One-Sample t-test testing whether mean Body Temperature=98.6";
RUN;

TITLE;
ODS PDF CLOSE;

*The t value is -5.45, and the p-value is <.0001 ==> We reject the Null Hypothesis at the 0.05 level;
