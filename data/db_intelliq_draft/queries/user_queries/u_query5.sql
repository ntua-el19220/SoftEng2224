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
    
/* I think we can do this with 2 joins instead of 3 like this:

SELECT q.questionnaireID, q.qID, s.session, a.optID
FROM
Question q
INNER JOIN Session s ON q.questionnaireID = s.questionnaireID
INNER JOIN Answer a ON s.session = a.session
WHERE q.qID = <....>
ORDER BY s.session                -- not sure if this order by is correct 

*/
