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

* POST-HOC;

ODS GRAPHICS;
ODS SELECT lsmeans diff diffplot controlplot;  *lsmeans: least square means;
PROC GLM DATA=STAT1.AMESHOUSING3 PLOTS(only)=(diffplot(center) controlplot);
	CLASS Heating_QC;
	MODEL SalePrice = Heating_QC;
	LSMEANS Heating_QC / PDIFF = all ADJUST=tukey; 
	LSMEANS Heating_QC / PDIFF = control("Average/Typical") ADJUST=dunnett;
	FORMAT Heating_QC $Heating_QC.;
	TITLE "Post-Hoc Analysis of ANOVA - Heating Quality as Predictor";
RUN;
QUIT;

TITLE;	

*The PDIFF= option requests p-values for the differences. PDIFF=ALL, which is the 
default, requests to compare all means, and produces a diffogram automatically.
The ADJUST= option specifies the adjustment method for multiple comparisons.
Recall that Tukeys adjustment will maintain the experimentwise error rate at 0.05
for all six pairwise comparisons.

In the second LSMEANS statement, the PDIFF=CONTROL option requests that each level 
be compared to a control level. We choose the appropriate control level based on
 the research goals. The control level is written in quotation marks. We're using
 'Average/Typical' as the control for demonstration purposes, which will result in
 three comparisons, one for each remaining level versus the control. Because we 
 specify the ADJUST=Dunnett option, the GLM procedure produces multiple comparisons
 using Dunnett's method. This method maintains an experimentwise error rate of 0.05
 for all three comparisons and creates a control plot.
 
 The PROC GLM statement includes the PLOTS= options. The DIFFPLOT option modifies
 the diffogram thats produced by the LSMEANS statement with the PDIFF=ALL option. 
 The CENTER option adds a dot to the intersection of two least squares means for
 each comparison. The CONTROLPLOT option requests a display in which least squares
 means are compared against a reference level. LS-mean control plots are produced 
 only when you specify PDIFF=CONTROL or ADJUST=DUNNETT in the LSMEANS statement. 
 In this case, theyre produced by default.
 
 
INTERPRETATION :
 Lets look at the Tukey LSMEANS comparisons. The other tables and results are identical
 to the previous demonstration. The first table shows the means for each group, and 
 each mean is assigned a number to refer to it in the next table. We can see that the
 average sale price of homes with Excellent heating quality is the highest, at 
 approximately $154,000. Homes with Fair heating quality have the lowest average price,
 at approximately $97,000. The other two levels are nearly equivalent at about $130,000.
 The second table shows the p-values from pairwise comparisons of all possible combinations
 of means. Notice that row 2 column 4 has the same p-value as row 4 column 2, because the same
 two means are compared in each case. Both are displayed as a convenience to the user. The
 diagonal is blank of course, because it doesnt make any sense to compare a mean to itself.
 The only nonsignificant pairwise difference is between Average/Typical and Good. These p-values
 are adjusted using the Tukey method and are, therefore, larger than the unadjusted p-values for
 the same comparisons. However, the experimentwise Type 1 error rate is held fixed at alpha. The 
 comparisons of least square means are also shown graphically in the diffogram. Six comparisons 
 are shown, but because the Average/Typical and Good levels have very close means, two pairs of
 lines are close together. The blue solid lines denote significant differences between heating 
 quality levels, because these confidence intervals for the difference do not cross the diagonal
 equivalence line. Red dashed lines indicate a non-significant difference between treatments.
 Starting at the top, left to right, we can see Excellent is significantly different from Fair,
from Good, and from Average/Typical. Then at the middle left, Good heating quality houses are s
ignificantly different from Fair, but not from Average/Typical. Finally, Average/Typical is 
significantly different from Fair heating quality in their mean sales price. The text on the 
graph tells us that the Tukey adjustments have been applied to these comparisons. Lets look at
 the Dunnetts LSMEANS comparisons as well. In this case, all other quality levels are compared 
 to Average/Typical. Once again, Good is the only level that is not significantly different from
 that control level.

The control plot corresponds to the tables that were summarized. The horizontal line is drawn at
 the least squares mean for Average/Typical, which is $130,574. The other three means are
 represented by the ends of the vertical lines extending from the horizontal control line. The 
 mean value for Good is so close to Average/Typical that it can't be seen here. Notice that the
 blue areas of non-significance vary in size. This is because different comparisons involve 
 different sample sizes. Smaller sample sizes require larger mean differences to reach statistical
 significance. This control plot shows significant differences between Excellent and 
 'Average/Typical', and between Fair and Average/Typical, just like in the table above. As weve 
 seen, tests for significant differences among treatments can be assessed graphically or through
 tables of p-values. Some people prefer graphs, others prefer the tables. Its our personal
 preference which to use;






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


*Performing a one-way ANOVA using PROC GLM. We must be sure to check that the assumptions of the 
analysis method that we choose are met;

ODS GRAPHICS;
PROC GLM DATA=STAT1.GARLIC PLOTS= diagnostics;
	CLASS  Fertilizer;
	MODEL BulbWt = Fertilizer;
	MEANS Fertilizer / HOVTEST=levene;
	TITLE "One-Way ANOVA with Fertilizer as Predictor";
RUN;
QUIT;

TITLE;


*The overall F value from the analysis of variance table is associated with a p-value of 0.0013.
 Presuming that all assumptions of the model are valid, we know that at least one treatment mean 
 is different from one other treatment mean. At this point, we don't know which means are 
 significantly different from one another. Both the histogram and Q-Q plot show that the residuals
 seem relatively normally distributed (one assumption for ANOVA).The Levene’s Test for Homogeneity
 of Variance table shows a p-value greater than alpha. Therefore, do not reject the hypothesis of 
 homogeneity of variances (equal variances across fertilizer types). This assumption for ANOVA is 
 met.;
 
 
 

* Performing a post hoc test to look at the individual differences among means;
ODS GRAPHICS;
ODS SELECT lsmeans diff diffplot controlplot;
PROC GLM DATA= STAT1.GARLIC PLOTS(only) = (diffplot(center) controlplot);
	CLASS Fertilizer;
	MODEL BulbWt = Fertilizer;
	LSMEANS Fertilizer / PDIFF= all ADJUST=tukey;
	TITLE "Post-Hoc Analysis of ANOVA - 'Fertilizer' as Predictor";
RUN;
QUIT;
TITLE;

/*This code is like the BulbWt LSMEAN table*/
PROC Means DATA= STAT1.GARLIC;
	VAR BulbWt;
	CLASS Fertilizer; 
RUN;

*The Tukey comparisons show significant differences between
 fertilizers 3 and 4 (p=0.0020) and 1 and 4 (p=0.0058).;




*Use level 4 (the chemical fertilizer) as the control
 group and perform a Dunnett's comparison with the organic
 fertilizers to see whether they affected the average 
 weights of garlic bulbs differently from the control 
 fertilizer.;

ODS GRAPHICS;
ODS SELECT lsmeans diff diffplot controlplot;
PROC GLM DATA= STAT1.GARLIC PLOTS(only)=(diffplot(center) controlplot);
	CLASS Fertilizer;
	MODEL BulbWt = Fertilizer;
	LSMEANS Fertilizer / PDIFF= control("4") ADJUST=dunnett;
	TITLE "Post-Hoc Analysis of ANOVA - 'Fertilizer' as Predictor";
RUN;
QUIT;

*The Dunnett comparisons show the same pairs as significantly different,
but with smaller p-values than with the Tukey comparisons (3 versus 4 p=0.0011,
1 versus 4 p=0.0031). This is due to the fact that the Tukey adjustment is for 
more pairwise comparisons than the Dunnett adjustment.;

ODS PDF CLOSE;
	

 
 
 
 

 