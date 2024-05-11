/*EXAMPLE 1*/

ODS PDF FILE = "/home/u63703188/My Personal statistic Folder/Two-Sample t-test Examples.pdf";
ODS GRAPHICS;

PROC TTEST DATA= STAT1.ameshousing3 PLOTS(shownull) = interval;
	CLASS  Masonry_Veneer;
	VAR SalePrice;
	FORMAT Masonry_Veneer $NoYes.;
	TITLE "Two-Sample t-test Comparing Mansory Venner : No vs Yes";
RUN;

TITLE;

*So based on the results of the F test, we now look in the t tests table
 at the t test for the hypothesis of equal means, the pooled t test. Here 
 we see that the p-value is less than .0001, which is less than 0.05, so we
 can reject the null hypothesis that the group means are equal. We can conclude 
 that the sale price of homes with masonry veneer is significantly different
 from homes without it.
 
 
 notice that the t statistic values for both tests are almost equal, -5.38 and -5.72.
 When the population variances are equal, the t values are equivalent mathematically.
 The slight difference here is due to random sampling differences when calculating the
 variances. We can make the same conclusion about the means from the confidence interval
 plot. We can see both pooled and Satterthwaite 95% confidence intervals. Notice for the
 pooled variance method, the confidence interval for the difference in means is between 
 about -$33,000 and -$15,000. It doesn't include 0, which is our hypothesized value. In 
 other words, we have enough evidence to say that the difference of the means is significantly
 different from 0 at the 95% confidence level. ;
 
 
 
 
 /*EXAMPLE 2*/

*;

ODS GRAPHICS;

PROC TTEST DATA=Stat1.german PLOTS(shownull) = interval;
	CLASS Group;
	VAR Change;
	TITLE "Two-Sample t-test : German Grammar Training, Comparing Treatment to Control";
RUN;

TITLE;


*Because the p-value for the Equality of Variances test is greater than the alpha level of 0.05, we would
 not reject the null hypothesis. This conclusion supports the assumption of equal variance (the null hypothesis 
 being tested here).
 
 
 The p-value for the Pooled (Equal Variance) test for the difference between the two means shows that the two
 groups are not statistically significantly different. Therefore, there is not strong enough evidence to say
 conclusively that the new teaching technique is different from the old. The Difference Interval plot displays 
 these conclusions graphically.;
 
 ODS PDF CLOSE;