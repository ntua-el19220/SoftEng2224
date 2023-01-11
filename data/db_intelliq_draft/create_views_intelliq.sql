USE intelliqDB;
/* view for questionnaire with possible answers */
DROP VIEW IF EXISTS view_Questionnaire;
CREATE VIEW view_Questionnaire AS
SELECT questionnaireTitle,qtext,opttxt
FROM Questionnaire q
         INNER JOIN Question a ON q.questionnaireID = a.questionnaireID
         INNER JOIN `Option` b ON b.qID = a.qID
GROUP BY q.questionnaireID;




/* view session from user */
DROP VIEW IF EXISTS view_Session_answers;
CREATE VIEW view_Session_answers AS
SELECT s.session,questionnaireTitle,qtext,opttxt
FROM Session s
     INNER JOIN Questionnaire q ON s.questionnaireID = q.questionnaireID
     INNER JOIN Answer a ON s.session = a.session
     INNER JOIN `Option` o ON a.optID = o.optID
     INNER JOIN Question ON Question.questionnaireID = q.questionnaireID AND o.qID = Question.qID;