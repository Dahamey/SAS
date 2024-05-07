/*Let's write a DATA step that calculates 3 years of projected sales for each
row of the SHOES table*/

DATA Forecast;
	SET SASHELP.SHOES(rename=(Sales = ProjectedSales)); *old_name=new_name;
	*with an annual sales increase of 5%;
	Year = 1;
	ProjectedSales = ProjectedSales * 1.05;
	output; *output the row that contain the projected price of the product in the 1st year;
	Year = 2;
	ProjectedSales = ProjectedSales * 1.05;
	output; *output the row that contain the projected price of the product in the 2nd year;
	Year = 3;
	ProjectedSales = ProjectedSales * 1.05;
	output; *output the row that contain the projected price of the product in the 3rd year;
	KEEP Region Product Subsidiary Year ProjectedSales;
	FORMAT ProjectedSales dollar10.;
RUN;

/* In each iteration of the DATA step, a row is read from the input table.
 Then, the 'Year' and 'ProjectedSales' columns are updated and the 'OUTPUT' statement
 writes a row to the Forecast table. This happens three times for each of the
 395 input rows for a total of 1185 rows in the output table. We notice the repetitive
 code in this program. There are three assignment statements for Year, three 
 assignment statements for ProjectedSales, and three OUTPUT statements.
 
 To eliminate having to type repetitive code, you can use the iterative 'DO' loop.*/

DATA Forecast;
	SET SASHELP.SHOES(rename = (Sales = ProjectedSales));
	DO Year = 1 TO 3 BY 1; *'BY 1' is actually by default;
		ProjectedSales = ProjectedSales * 1.05;
		output;
	END;
	KEEP Region Product Subsidiary Year ProjectedSales;
	FORMAT ProjectedSales dollar10.;
RUN;
		
	
/*The value of the index column ('Year') is incremented at the bottom of the 'DO' loop,
after each row is written to the output table*/
DATA Forecast;
	SET SASHELP.SHOES(rename = (Sales = ProjectedSales) obs=2);
	DO Year = 1 TO 3 BY 1; *'BY 1' is actually by default;
	PUTLOG "NOTE:";
	PUTLOG Year=;
		ProjectedSales = ProjectedSales * 1.05;
		output;
	PUTLOG "NOTE:";
	PUTLOG Year=;
	END;
	KEEP Region Product Subsidiary Year ProjectedSales;
	FORMAT ProjectedSales dollar10.;
	
RUN;


/*There are times when you don't know how many times the DO loop needs to iterate.
In this case, we use a conditional DO loop

--------------------------------------
DO UNTIL (expression);
	...repetitive code...
END;
--------------------------------------
'DO UNTIL' : Executes until a condition is True, the condition in the loop is checked at the bottom (before END).

--------------------------------------
DO WHILE (expression);
	...repetitive code...
END;
--------------------------------------
'DO WHILE' : Executes while a condition is True, the condition in the loop is checked at the top.*/


***********************************************************;
*  Using Conditional DO Loops                             *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    DATA output-table;                                   *;
*       SET input-table;                                  *;
*       . . .                                             *;
*       DO UNTIL | WHILE (expression);                    *;   
*          . . . repetitive code . . .                    *;
*          OUTPUT;                                        *;
*       END;                                              *;
*       DO index-column = start TO stop <BY increment>    *;
*          UNTIL | WHILE (expression);                    *;
*          . . . repetitive code . . .                    *;
*          OUTPUT;                                        *;
*       END;                                              *;
*       . . .                                             *;
*       OUTPUT;                                           *;
*    RUN;                                                 *;
***********************************************************;

***********************************************************;
*  Demo                                                   *;
*  1) Open the PG2.SAVINGS2 table. This table contains a  *;
*     column named Savings that is the current value of   *;
*     each person's savings account. Notice that Linda's  *;
*     value is already greater than 3000.                 *;
*  2) Notice the DO UNTIL expression is Savings equal to  *;
*     3000. Run the program. Because Savings is never     *;
*     equal to 3000, the program is in an infinite loop.  *;
*     Stop the infinite DO loop from running.             *;
*     * In SAS Enterprise Guide, click the Stop toolbar   *;
*       button on the Program tab.                        *;
*     * In SAS Studio, click Cancel in the Running pop-up *;
*       window.                                           *;
*  3) Make the following modifications to the DATA step.  *;
*     a) Replace the equal sign with a greater than       *;
*        symbol.                                          *;
*     b) Add a sum statement inside the DO loop to create *;
*        a column named Month that will increment by 1    *;
*        for each loop.                                   *;
*     c) Before the DO loop add an assignment statement   *;
*        to reset Month to 0 each time a new row is read  *;
*        from the input table.                            *;
*  4) Run the program. Notice that even though Linda      *;
*     began with 3600 for Savings, the DO LOOP executed   *;
*     once.                                               *;
*  5) Change the DO UNTIL expression to DO WHILE so that  *;
*     the condition will be checked at the top of the     *;
*     loop. Run the program and verify Linda's Savings    *;
*     amount is 3600.                                     *;
***********************************************************;

/* Step 2 */
data MonthSavings;
    set pg2.savings2;
    do until (Savings=3000);
       Savings+Amount;
       Savings+(Savings*0.02/12);
    end;
    format Savings comma12.2;
run;

/* Step 3 */
data MonthSavings;
    set pg2.savings2;
    Month=0;
    do until (Savings>3000);
       Month+1;
       Savings+Amount;
       Savings+(Savings*0.02/12);
    end;
    format Savings comma12.2;
run;

/* Step 4 */
data MonthSavings;
    set pg2.savings2;
    Month=0;
    do while (Savings<3000);
       Month+1;
       Savings+Amount;
       Savings+(Savings*0.02/12);
    end;
    format Savings comma12.2;
run;



***********************************************************;
*  Using Conditional DO Loops                             *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    DATA output-table;                                   *;
*       SET input-table;                                  *;
*       . . .                                             *;
*       DO UNTIL | WHILE (expression);                    *;
*          . . . repetitive code . . .                    *;
*          OUTPUT;                                        *;
*       END;                                              *;
*       DO index-column = start TO stop <BY increment>    *;
*          UNTIL | WHILE (expression);                    *;
*          . . . repetitive code . . .                    *;
*          OUTPUT;                                        *;
*       END;                                              *;
*       . . .                                             *;
*       OUTPUT;                                           *;
*    RUN;                                                 *;
***********************************************************;

***********************************************************;
*  Demo                                                   *;
*  1) The intent of both DATA steps is process the DO     *;
*     loop for each row in the PG2.SAVINGS2 table. One    *;
*     DATA step uses DO WHILE and the other uses DO       *;
*     UNTIL. Each loop represents one month of savings.   *;
*     The loop should stop iterating when Savings exceeds *;
*     3000 or 12 months pass, whichever comes first.      *;
*  2) Run the demo program and view the 2 reports that    *;
*     are created. Notice that the values of Savings in   *;
*     the DO WHILE and DO UNTIL reports match, indicating *;
*     that the DO loops executed the same number of times *;
*     for each person.                                    *;
*  3) Observe that for the first row in both the DO WHILE *;
*     and DO UNTIL reports has Month equal to 13. Savings *;
*     did not exceed $5,000 after 12 iterations of the DO *;
*     loop. The Month index variable was incremented to   *;
*     13 at the end of the twelfth iteration of the loop, *;
*     which triggered the end of the loop in both DATA    *;
*     steps and an implicit output action to the output   *;
*     table.                                              *;
*  4) Observe that in rows 2, 3 and 4, the value of Month *;
*     in the DO WHILE results is one greater compared to  *;
*     the DO UNTIL results. This is because in the DO     *;
*     WHILE loop, the index variable Month increments     *;
*     before the condition is checked. Therefore, the     *;
*     Month column in the output data does not accurately *;
*     represent the number of times the DO loop iterated  *;
*     in either DATA step.                                *;
*  5) To create an accurate counter for the number of     *;
*     iterations of a DO loop, make the following         *;
*     modifications to both DATA steps:                   *;
*     a) Add a sum statement inside the loop to create a  *;
*        column named Month and add 1 for each iteration. *;
*     b) Before the DO loop add an assignment statement   *;
*        to reset Month to 0 each time a new row is read  *;
*        from the input table.                            *;
*     c) Change the name of the index variable to an      *;
*        arbitrary name, such as i.                       *;
*     d) Add a DROP statement to drop i from the output   *;
*        table.                                           *;
*  6) Run the program and examine the results. Notice the *;
*     values of Savings and Month match for the DO WHILE  *;
*     and DO UNTIL reports. Month represents the number   *;
*     of times the DO loop executed for each row.         *;
***********************************************************;

data MonthSavingsW;
    set pg2.savings2;
	Month=0;
    do i=1 to 12 while (savings<=5000);
		Month+1;
	    Savings+Amount;
        Savings+(Savings*0.02/12);
    end;
    format Savings comma12.2;
	drop i;
run;

data MonthSavingsU;
    set pg2.savings2;
	Month=0;
    do i=1 to 12 until (savings>5000);
		Month+1;
        Savings+Amount;
        Savings+(Savings*0.02/12);
    end;
    format Savings comma12.2;
	drop i;
run;

ods pdf file="/home/u63703188/MyPersonalFolder/DO_WHILE_UNTIL_report.pdf" startpage=NO;
title "DO WHILE Results";
proc print data=MonthSavingsW;
run;

title "DO UNTIL Results";
proc print data=MonthSavingsU;
run;
ods pdf close;
