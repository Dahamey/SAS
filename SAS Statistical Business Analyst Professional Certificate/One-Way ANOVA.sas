/*Performing One-Way ANOVA*/


*Lets use PROC GLM to run an analysis of variance to test whether the average
 SalePrice differs among the houses with different heating qualities. Before we can
 trust the results from our ANOVA, such as the p-values and confidence intervals, we 
 need to check the assumptions of our model. Well use Levenes test of homogeneity of
 variances to assess constant variance. We can check normality and independence through
 residual plots such as histograms, Q-Q plots, residual versus predicted values, and
 residual versus predictor plots. In the PROC GLM statement, we specify the ameshousing3
 data set, and include the PLOTS=diagnostics option to produce a panel display of the
 diagnostic plots. The CLASS statement indicates our categorical predictor variable,
 Heating_QC. In the MODEL statement, we specify the dependent and independent variables
 as indicated in the ANOVA model, SalePrice=Heating_QC. The MEANS statement computes
 the unadjusted means, or arithmetic means, of the dependent variable SalePrice for each
 level of the specified effect, Heating_QC. We can also use the MEANS statement to test 
 the assumption of equal variances. To do so, we add the HOVTEST=levene option. This
 option performs Levene's test for homogeneity of variances by default. The null
 hypothesis is that all group variances are equal. If the resulting p-value of 
 Levene's test is greater than some critical value, typically0.05, we fail to reject 
 the null hypothesis and conclude that group variances are not statistically different.;

ODS PDF FILE = "/home/u63703188/My Personal statistic Folder/One-Way ANOVA.pdf"
	STARTPAGE=NO;
ODS GRAPHICS;

PROC GLM DATA= STAT1.AMESHOUSING3 PLOTS= diagnostics;
	CLASS  Heating_QC;
	MODEL SalePrice = Heating_QC;
	MEANS Heating_QC / hovtest= Levene;
	FORMAT Heating_QC $Heating_QC.;
	TITLE "One-Way ANOVA with Heating Quality as Predictor";
RUN;
QUIT;

TITLE;



/*EXAMPLE2*/
*PROC MEANS to generate descriptive statistics for the four groups;
PROC MEANS DATA=STAT1.GARLIC;
		VAR  BulbWt;
		CLASS Fertilizer;
		TITLE "Descriptive Statistics of BulbWt by Fertilizer";
RUN;

*PROC SGPLOT to produce box plots of bulb weight for the four groups;

PROC SGPLOT DATA=STAT1.GARLIC;
	VBOX BulbWt / CATEGORY = Fertilizer CONNECT = mean;
	TITLE "Bulb Weight Differences across Fertilizers";
RUN;


*Performing a one-way ANOVA using PROC GLM. We must be sure to check that the assumptions of the analysis method that we choose are met;

ODS GRAPHICS;
PROC GLM DATA=STAT1.GARLIC PLOTS= diagnostics;
	CLASS  Fertilizer;
	MODEL BulbWt = Fertilizer;
	MEANS Fertilizer / HOVTEST=levene;
	TITLE "One-Way ANOVA with Fertilizer as Predictor";
RUN;
QUIT;

TITLE;
ODS PDF CLOSE;
	
*The overall F value from the analysis of variance table is associated with a p-value of 0.0013.
 Presuming that all assumptions of the model are valid, we know that at least one treatment mean 
 is different from one other treatment mean. At this point, we don't know which means are 
 significantly different from one another. Both the histogram and Q-Q plot show that the residuals
 seem relatively normally distributed (one assumption for ANOVA).The Levene’s Test for Homogeneity
 of Variance table shows a p-value greater than alpha. Therefore, do not reject the hypothesis of 
 homogeneity of variances (equal variances across fertilizer types). This assumption for ANOVA is 
 met.;
 
 