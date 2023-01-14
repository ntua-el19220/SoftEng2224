SELECT questionnaireID, questionnaireTitle
FROM Questionnaire
WHERE questionnaireID = '{questionnaireID}'


-- For questionnaire's keywords
SELECT word
FROM Keyword
WHERE questionnaireID = '{questionnaireID}'


-- For questionnaire's questions
SELECT q.qID as qID, q.qtext as qtext, q.required as required, q.type as type
FROM question q 
WHERE q.questionnaireID = '{questionnaireID}'
ORDER BY q.qID
