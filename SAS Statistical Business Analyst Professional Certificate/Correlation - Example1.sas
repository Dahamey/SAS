/*CORRELATION*/

/*EXAMPLE1*/  
ODS PDF FILE="/home/u63703188/My Personal statistic Folder/Correlation Example1.pdf" STARTPAGE=NO;
* Numeric columns;
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;


* The PROC CORR statement specifies AmesHousing3 as the data set. To rank-order the absolute value 
of the correlations from highest to lowest, we're using the RANK option. To request individual 
scatter plots, we specify the PLOTS=SCATTER option. After the keyword SCATTER, we see two more 
options. NVAR=ALL specifies that all the variables listed in the VAR statement be displayed in the
 plots, and ELLIPSE=NONE suppresses the drawing of ellipses on scatter plots. The VAR statement 
 specifies the continuous variables that we want correlations for. By default, SAS produces 
 correlations for each pair of variables in the VAR statement, but we'll use the WITH statement to
 correlate each continuous variable with SalePrice. The IMAGEMAP option in the ODS GRAPHICS statement
 enables tooltips to be used in HTML output. Tooltips enable we to identify data points by moving 
 the cursor over observations in a plot. In PROC CORR, the variables used in the tooltips are the 
 X-axis and Y-axis variables, the observation number, and any variable in the ID statement, which 
 in this case, is the variable PID.;
 
ODS GRAPHICS / RESET = ALL IMAGEMAP;
PROC CORR DATA=STAT1.AMESHOUSING3 RANK PLOTS(only) = Scatter (NVAR=all ELLIPSE=none);
	VAR &interval;
	WITH SalePrice;
	ID PID;
	TITLE "Correlations and Scatter Plots with SalePrice";
RUN;
TITLE;


* By default, the PROC CORR analysis first generates a list of the variables that were analyzed. It
 also displays descriptive statistics for each variable, including the mean, standard deviation, and
 minimum and maximum values. Here we can see the correlation coefficients and p-values for the correlation
 of 'SalePrice' with each of the predictor variables. Notice that the table is ranked by the absolute
 correlation coefficient. 'Basement_Area' has the strongest linear association with the response variable with 
 a correlation coefficient of about 0.69. Therefore, 'Basement_Area' would be the best single predictor of 'SalePrice'
 in a simple linear regression. The p-value is small, which indicates that the population correlation coefficient, ρ (rho),
 is likely different from 0. The second largest magnitude correlation coefficient is 'Above Ground Living Area' at about 0.65,
 and so on. Let's look at the scatter plots. 'Above Ground Living Area' seems to exhibit a noticeably positive linear association
 with 'SalePrice'. Of course, the scatter plot with 'Basement_Area' also shows a positive linear relationship. Notice that there are
 several houses that have basements with a size of zero square feet. These are houses without basements, not missing values. 
 This mixture of data can affect the correlation coefficient. we would need to take this into account if we build a model with
 'Basement_Area' as a predictor variable. we can move the cursor over the observation to display the coordinate values, observation
 number, and ID variable values. 
 
The scatter plots with total deck area and lot size show the variables have weak correlations with 'SalePrice', because a horizontal
 line could be an adequate line of best fit. As expected, 'SalePrice' and the age of the house when sold have a negative linear 
 relationship. The older the house, the less the home tends to sell for. The scatter plots with the total number of bedrooms and 
 bathrooms have few continuous values and could be analyzed as classification variables. These plots are basically displaying the 
 distribution of 'SalePrice' at each level, similarly to a box plot. However, the scatter plot with total number of bathrooms seems 
 to exhibit a positive linear relationship, as the center of the distributions tends to increase as the number of bathrooms 
 increases. Overall, the correlation and scatter plot analyses indicate that several variables might be good predictors for 'SalePrice'.
 When we prepare to conduct a regression analysis, it's always a good practice to examine the correlations among the potential predictor variables.
 This is because strong correlations among predictors included in the same model can cause a variety of problems, like multicollinearity;
 
 
 
ODS GRAPHICS OFF;
PROC CORR DATA= STAT1.ameshousing3 NOSIMPLE BEST=3;
	VAR &interval;
	TITLE "Correlations and Scatter Plot Matrix of Predictors";
RUN;
TITLE;


*We want to produce a correlation matrix to help us compare the relationships between predictor variables. The correlation matrix 
shows correlations and p-values for all combinations of the predictor variables. Here we'll limit our attention to the strongest 
three correlations with each predictor. In this PROC CORR statement, we're using the NOSIMPLE option to suppress the printing of 
the simple descriptive statistics for each variable. The BEST= option prints the n highest correlation coefficients for each variable,
 so in this case, the three strongest correlations.

In the results, notice that the variables are still listed, but the table of simple statistics is gone. There are moderately strong
 correlations between Total_Bathroom and Age_Sold, -0.52889, between Total_Bathroom and Basement_Area, 0.48500, and between 'Bedroom_AbvGr' and
 'above Gr_Liv_Area', 0.48431. If some of these potential predictors were highly correlated, we might omit some from the multiple 
 regression models that we'll produce later in the course. Strong correlations among sets of predictors, also known as multicollinearity,
 can cause a variety of problems for statistical models. Correlation analysis has the potential to reveal multicollinearity problems, but 
 additional methods to detect it are necessary. Bivariate correlations in the range shown above are not causes for concern.;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /*Correlation Analysis and Model Building
Correlations between the response variable and potential predictors can be useful by suggesting variables that should be included 
or excluded from model building. Often, modelers have many predictors, and thus, a very large number of possible models to explore.
   Predictors with a weak or no relationship with the response variable might sometimes be excluded. Typically, the decision to 
   throw out a variable is based on multivariable analyses. However, if the modeler has far more predictors than can be used and 
   variable reduction becomes necessary (often under time pressure), predictors with weak or no correlation with the response 
   variable are good candidates for exclusion.   Part of correlation analysis involves visually assessing associations between 
   variables by looking at scatter plots. When these plots reveal patterns in the data, such as curvilinear relationships, a modeler might 
   need to build additional terms into the model, such as polynomials.  Another reason to create scatter plots is to assess the 
   linear relationship between pairs of predictor variables. When predictors are highly correlated, they provide redundant information.
   Multicollinearity (strong correlations among sets of predictors) can destabilize parameter estimates and degrade the ability of 
   model selection routines, such as stepwise selection, to select good variables.   Correlation analysis is one of several ways to
   address collinearity prior to model building. */
  
ODS PDF CLOSE; 





