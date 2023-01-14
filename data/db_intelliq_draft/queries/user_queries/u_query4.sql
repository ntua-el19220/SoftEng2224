/*          USER QUERY 2=4 --> d. {baseURL}/getsessionanswers/:questionnaireID/:session     */
SELECT
    s.questionnaireID, s.session, q.qID,a.optID
FROM
    Session s
        INNER JOIN Answer a ON s.session = a.session
        INNER JOIN `Option` o ON a.optID = o.optID
        INNER JOIN Question q ON o.qID = q.qID
WHERE
        s.session = '{session}'
ORDER BY
    q.qID
