/*      USER QUERY 1 --> a. {baseURL}/questionnaire/:questionnaireID          */

SELECT
    q.questionnaireTitle, q.questionnaireID,
    k.word as keywords,
    u.qID,u.qtext,u.required,u.type
FROM
    Questionnaire q
        INNER JOIN Question u ON q.questionnaireID = u.questionnaireID
        LEFT JOIN Keyword k ON k.questionnaireID = q.questionnaireID
WHERE
        q.questionnaireID = 'QQ001'
ORDER BY u.qID

/*
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
*/