
/* view for questionnaire with possible answers */
DROP VIEW IF EXISTS view_Questionnaire;
CREATE VIEW view_Questionnaire AS 
SELECT questionnaireTitle, qtext, opttxt
FROM Questionnaire, Question, 'Option'
WHERE Questionnaire.questionnaireID = Question.questionnaireID and 'Option'.qID = Question.qID;


/* view session from user */
DROP VIEW IF EXISTS view_Quview_Session_answersestionnaire;
CREATE VIEW view_Session_answers AS
SELECT Session.session, questionnaireTitle, qtext, opttxt
FROM Questionnaire, Question, 'Option', Session, Answer
WHERE Questionnaire.questionnaireID = Question.questionnaireID and 'Option'.qID = Question.qID and
		Session.questionnaireID = Question.questionnaireID and 'Option'.optID = Answer.optID and Session.session = Answer.session