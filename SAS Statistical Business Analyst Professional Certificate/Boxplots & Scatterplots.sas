ODS PDF FILE = "/home/u63703188/My Personal statistic Folder/Boxplots and Scartterplots.pdf"
	STARTPAGE=NO STYLE= Sapphire;
/*Creating a boxplot*/


/*using the VBOX statement to create a vertical box plot that shows the distribution
 of our data, and specifying the variable for the Y axis, SalePrice, followed by a 
 forward slash. The CATEGORY= option specifies the category variable and creates 
 different box plots for each distinct value.*/ 

PROC SGPLOT	  DATA= stat1.AMESHOUSING3;
	VBOX SalePrice / CATEGORY = Central_Air
					 CONNECT= mean;
	TITLE "Sale Price Differences across Central Air";
RUN;


*Creating mutltiple boxplots;

%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;

/*PROC SGPLOT is used here with the VBAR statement to produce vertical bar charts*/
/*PROC SGPLOT can only produce one plot at a time and so the macro is written to*/
/*produce one plot for each member in the list of the &categorical macro variable.*/
/*
      Macro Usage:
      %box(DSN = <data set name>,
           Response = <response variable name>,
           CharVar = <bar chart grouping variable list>)
*/
%macro box(dsn      = ,
           response = ,
           Charvar  = );

%let i = 1 ;

%do %while(%scan(&charvar,&i,%str( )) ^= %str()) ;

    %let var = %scan(&charvar,&i,%str( ));

    proc sgplot data=&dsn;
        vbox &response / category=&var 
                         grouporder=ascending 
                         connect=mean;
        title "&response across Levels of &var";
    run;

    %let i = %eval(&i + 1 ) ;

%end ;

%mend box;

%box(dsn      = STAT1.ameshousing3,
     response = SalePrice,
     charvar  = &categorical);

title;

options label;










/*Creating a Scatterplot*/

PROC SGSCATTER DATA = STAT1.AMESHOUSING3;
	PLOT SalePrice * Gr_Liv_Area / REG;
	TITLE "Associations of Above Grade Living Area with Sale Price";
RUN;

*An advantage of using PROC SGSCATTER is that you can create a panel 
of multiple scatter plots using a single PROC step :;

* Continuous variables;
%LET interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
options nolabel;     *Not to use labels for the variables;
PROC SGSCATTER DATA= STAT1.AMESHOUSING3;
	PLOT SalePrice * (&interval) / REG;
	TITLE "Associations of Interval (i.e. Continuous) Variables with Sale Price";
RUN;

ODS PDF CLOSE;