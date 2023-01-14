SELECT
    q.questionnaireID, q.qID, q.qtext, q.required, q.type,
    o.optID, o.opttxt, o.nextqID
FROM
    Question q
        INNER JOIN `Option` o on o.qID = q.qID
WHERE
        q.questionnaireID = '{questionnaireID}' AND
        q.qID = '{qID}'
order by o.optID