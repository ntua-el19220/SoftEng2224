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
    
/* 
Don't think we have to make the last join since we only care about qID which already exists in the `Option` table. 
Also we should filter with the questionnaireID as well as the session.
So maybe something like this would be better:

SELECT s.questionnaireID, s.session, o.qID, o.optID
FROM 
Session s 
INNER JOIN Answer a ON s.session = a.session
INNER JOIN `Option` o ON a.optID = o.optID
WHERE s.session = <.....> and s.questionnaireID = <.....>
ORDER BY o.qID

*/
