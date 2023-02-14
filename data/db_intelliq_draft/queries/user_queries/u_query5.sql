/*          USER QUERY 2=4 --> d. {baseURL}/getsessionanswers/:questionnaireID/:session     */

SELECT
    q.questionnaireID, q.qID, s.session, a.optID
FROM
    Question q
        INNER JOIN Option o ON q.qID = o.qID
        INNER JOIN Answer a ON a.optID = o.optID
        INNER JOIN Session s ON a.session = s.session
WHERE
    q.qID = '{qID}'
ORDER BY
    s.created_at
