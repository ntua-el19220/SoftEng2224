/*      USER QUERY 1 --> a. {baseURL}/questionnaire/:questionnaireID          */
/*
SELECT
    q.questionnaireTitle,
    q.questionnaireID,
    GROUP_CONCAT(DISTINCT k.word ORDER BY k.word) AS keywords,
    GROUP_CONCAT(DISTINCT
                 CONCAT_WS(',', u.qID, u.qtext, u.required, u.type)
                 ORDER BY u.qID) AS questions
FROM
    Questionnaire q
        INNER JOIN Question u ON q.questionnaireID = u.questionnaireID
        LEFT JOIN Keyword k ON k.questionnaireID = q.questionnaireID
WHERE
        q.questionnaireID = '{specific questionnaire ID}'
GROUP BY
    q.questionnaireID
*/

SELECT
    q.questionnaireTitle,
    q.questionnaireID,
    GROUP_CONCAT(DISTINCT k.word) AS keywords,
    u.qID,u.qtext,u.required,u.type
FROM
    Questionnaire q
        INNER JOIN Question u ON q.questionnaireID = u.questionnaireID
        LEFT JOIN Keyword k ON k.questionnaireID = q.questionnaireID
GROUP BY
    q.questionnaireID,u.qID
ORDER BY
    u.qID;
