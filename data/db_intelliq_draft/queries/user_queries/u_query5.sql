/*          USER QUERY 2=4 --> d. {baseURL}/getsessionanswers/:questionnaireID/:session     */

SELECT
    s.questionnaireID, o.qID, s.session, a.optID
FROM
    Question q
        INNER JOIN `Option` o ON q.qID = o.qID
        INNER JOIN Session s ON s.questionnaireID = q.questionnaireID
        INNER JOIN Answer a ON a.optID = o.optID
WHERE
        q.questionnaireID = '{questionnaireID}' AND
        q.qID = '{qID}'
ORDER BY
    s.session
