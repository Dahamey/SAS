/*CORRELATION*/
/*EXAMPLE2 :
.
Question 1
The percentage of body fat, age, weight, height, and 10 body circumference measurements (for example, abdomen) were recorded for
 252 men by Dr. Roger W. Johnson of Calvin College in Minnesota. The data are in the stat1.bodyfat2 data set. Body fat, one measure of health,
 has been accurately estimated by a water displacement measurement technique.
 
 
1/ Generate scatter plots and correlations for the VAR variables Age, Weight, and Height, and the circumference measures Neck, 
Chest, Abdomen, Hip, Thigh, Knee, Ankle, Biceps, Forearm, and Wrist versus the WITH variable, PctBodyFat2.  
**IMPORTANT: For PROC CORR, ODS Graphics will display a maximum of 10 VAR variable plots at a time. This practice analyzes thirteen variables,
 so it requires two PROC CORR steps to generate all thirteen plots. This limitation only applies to the ODS graphics. The correlation table
 displays all variables in the VAR statement by default.

2/ Write a PROC CORR step to analyze all thirteen variables (Age, Weight, Height, Neck, Chest, Abdomen, Hip, Thigh, Knee, Ankle, Biceps, Forearm, and Wrist ).
 This will generate a correlation table for all of the variables, but it will display plots for only the first ten.

3/ Write an ODS statement to limit the graphic output to scatter plots.

4/ Write another PROC CORR step, to look at only the last three variables, Biceps, Forearm, and Wrist.

5/ Submit the code. The output should include a correlation table for all thirteen variables followed by a plots for the first ten, and then plots for the last 
three. 

6/ Examine the plots. Can straight lines adequately describe the relationships?*/  

ODS PDF FILE="/home/u63703188/My Personal statistic Folder/Correlation Example2.pdf" STARTPAGE=NO;
%let interval=Age Weight Height Neck Chest Abdomen Hip 
              Thigh Knee Ankle Biceps Forearm Wrist;

ods graphics / reset=all imagemap;
proc corr data=STAT1.BodyFat2 RANK
          plots(only)=scatter(nvar=all ellipse=none);
   var &interval;
   with PctBodyFat2;
   id Case;
   title "Correlations and Scatter Plots";
run;

%let interval=Biceps Forearm Wrist;

ods graphics / reset=all imagemap;
ods select scatterplot;
proc corr data=STAT1.BodyFat2 RANK
          plots(only)=scatter(nvar=all ellipse=none);
   var &interval;
   with PctBodyFat2;
   id Case;
   title "Correlations and Scatter Plots";
run;
*'Height' seems to be the only variable that shows no real linear relationship. 'Age' and 'Ankle' show little linear trend;  

/*Question 2 :Are there any outliers you should investigate?

Yes, One person has outlying values for several measurements. In addition, there are one or two values that seem to be outliers for Ankle.

Question 3 : Which variable has the highest correlation with PctBodyFat2?

Abdomen, with r=0.81343, is the variable with the highest correlation with PctBodyFat2.  

4.
Question 4 :Generate correlations among all the variables previously mentioned (Age, Weight, Height, Neck, Chest, Abdomen, Hip, Thigh, Knee, Ankle, Biceps, Forearm, and Wrist) 
minus PctBodyFat2. Use the OUT= option in the PROC CORR statement to output the correlation table into a data set named pearson. Use the BEST= option to select only the highest
five per variable. 

Submit the code and review the results.  Are there any notable relationships? 
*/

ods graphics off;
%let interval=Age Weight Height Neck Chest Abdomen Hip Thigh
              Knee Ankle Biceps Forearm Wrist;

proc corr data=STAT1.BodyFat2 
          nosimple 
          best=5
          out=pearson;
   var &interval;
   title "Correlations of Predictors";
run;

/*Several relationships appear to have high correlations (such as those among Hip, Thigh, and Knee). Weight seems to correlate highly with all circumference variables.*/

ODS PDF CLOSE;