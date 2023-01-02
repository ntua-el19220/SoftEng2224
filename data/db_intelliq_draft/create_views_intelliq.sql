
/* view for questionnaire with possible answers */

CREATE VIEW view_Questionnaire AS 
SELECT questionnaireTitle, qtext, opttxt
FROM Questionnaire, Question, OPT 
WHERE Questionnaire.questionnaireID = Question.questionnaireID and OPT.qID = Question.qID
/*

ORDER BY questionnaireID, qID 
								*/



/* view session from user */

CREATE VIEW view_session_answers AS
SELECT SESS.sessID, questionnaireTitle, qtext, opttxt
FROM Questionnaire, Question, OPT, SESS, Answer
WHERE Questionnaire.questionnaireID = Question.questionnaireID and OPT.qID = Question.qID and 
		SESS.questionnaireID = Question.questionnaireID and OPT.optID = Answer.optID and SESS.sessID = Answer.sessID