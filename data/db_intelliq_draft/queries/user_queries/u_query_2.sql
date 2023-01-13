/*          USER QUERY 2 --> b. {baseURL}/question/:questionnaireID/:questionID     */


SELECT
    q.questionnaireID, q.qID, q.qtext, q.required, q.type,
    o.optID, o.opttxt, o.nextqID
FROM
    Question q
        JOIN `Option` O on o.qID = q.qID
WHERE
        q.questionnaireID = 'QQ001' AND
        q.qID = 'P0015'
order by o.optID