# SAS/SAS Statistical Business Analyst Professional Certificate

This certificate program offered a focused exploration of statistical analysis techniques using SAS software. Key chapters covered hypothesis testing, regression modeling fundamentals, and predictive modeling with logistic regression.



Program Files
The EST142 folder contains three subfolders:

data - contains the SAS data sets needed to run the demos and practices.

demos - contains the demo program files.

solutions - contains the solution program files.

The filenames for the .SAS files in the demos and solutions folders have a d for demo code or an s for solution code. If you want to do the demo in your software, you can see the filename of the demo code you need to open in a comment at the top of the program in the demo video. In practices, the name of the solution code file is in a comment at the top of the solution. 

SAS Syntax
Partial SAS syntax is displayed and explained in the demos. To view detailed syntax from SAS Studio, click the Help button near the top right and select SAS Product Documentation. 

Exploring SAS Data Sets in SAS Studio
You can use the table viewer in SAS Studio to explore SAS data sets.

Open SAS Studio. In the navigation pane on the left, double-click Libraries. Expand My Libraries and then expand the SASHELP library.

Open the CARS data set by double-clicking it or by dragging it to the work area on the right. The data set opens in the table viewer. By default all of the columns and the first 100 rows are displayed. You can use the arrows above the table (top right) to page forward and backward through the rows.

Clear the Select all checkbox in the Columns area of the table viewer. No columns are displayed. Select the Make, Model, and Type check boxes. The corresponding columns are displayed.

Select Make in the column list. The column properties are displayed below the list.

Close the table tab.

Exploring SAS Data Sets Programmatically
You can use the PRINT procedure to display the rows of a SAS table, and the CONTENTS procedure to display the table metadata.

In the PROC PRINT step, you use the DATA= option to name the input data set and the VAR statement to select the columns to display. By default, SAS lists all columns and all rows, but you can use the OBS=n data set option to limit the display to the first n rows. In the PROC CONTENTS step, you use the DATA= option to name the input data set.
