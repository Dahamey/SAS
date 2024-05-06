/*Manipulating Data With functions, specifying column lists*/

DATA quiz_ummary;
	SET pg2.class_quiz;
	Name = UPCASE(Name); * Younes ---> YOUNES;
	AvgQuiz = MEAN(of Q:); *mean(quiz1, quiz2, quiz3, quiz4, quiz5);
	FORMAT Quiz1--AvgQuiz 3.1; *fomatting all the columns in the physical range of the columns from left (strating with Quiz1) to right(ending with AvgQuiz) to 3.1;
RUN;

DATA quiz_ummary;
	SET pg2.class_quiz;
	Name = UPCASE(Name); * Younes ---> YOUNES;
	AvgQuiz = MEAN(of Q:); *mean(quiz1, quiz2, quiz3, quiz4, quiz5);
	FORMAT _NUMERIC_ 3.1; * formats all the numerical columns in the table to 3.1 format;
RUN;

/*Using a CALL routine to modify data*/

* The 'CALL SORTN'routine takes the columns provided as args, and reorder the 
numeric values for each row from low to high. We notice that we're not assigning
these values to new columns, but instead the data values are ordered in the existing columns;

* We want to have the top3 grades from each student in the table 'class_quiz' and 
calculate the average to these 3 grades;
DATA quiz_report;
	SET pg2.class_quiz;
	CALL SORTN(of Quiz1-QUiz5);  *Sorting the grades from low to high for each student----after sorting----> q1<q2<q3<q4<q5;
	QuizAvg = MEAN(of Quiz3-Quiz5); *The average of the top3 grades (q3, q4, q5) for each student;
RUN;