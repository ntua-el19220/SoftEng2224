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
Not sure if it works. 
Think about this example: let's say we want to find the questions and keywords of the qustionnaire with questionnaireID = 15.
Let's say that this questionnaire has only 3 questions with qID = 1,2,3 respectively.
And let's say that it has 3 keywords (one for each question) with keywordID = 4, 5, 6 such that question with qID = 1 has
the keyword with keywordID = 4, question with qID = 2 has the keyword with keywordID = 5 and question with qID = 3 has the keyword with keywordID = 6.
When we inner join questionnaire and question on questionnaireID we are left with this table (ignoring the other questionnaireID that might be in the 
database) : 
questionnaireID  qID
15               1
15               2
15               3

Then if we inner join this table with the Keyword table on questionnaireID we have this table:
questionnaireID  qID   keywordID
15               1      4
15               1      5
15               1      6
15               2      4
15               2      5
15               2      6
15               3      4
15               3      5
15               3      6

This is wrong as question 1 doesn't have the keywords 5 and 6, question 2 doesn't have the keywords 4 and 6 and question 3 doesn't have the keywords 4 and 5.
(the problem is that we inner join twice on questionnaireID creating a very big table).
Instead we should make a table that looks like this:
questionnaireID  qID    keywordID
15               1      4
15               2      5
15               3      6
i.e each line has the question and the keyword associated with that question (assuming that our database is correct, if the questionnaire has N keywords 
then at least one question should be associated with every keyword aka we have at least the same amount of questions as keywords in each questionnaire 
since in our relational model we assumed that each question has either 1 or 0 keywords)

To achieve this I think the query should look like this:

SELECT q.questionnaireID, q.questionnaireTitle, k.word, u.qID, u.qtext, u.required, u.type
FROM 
Questionnaire q
INNER JOIN Question u on u.questionnaireID = q.questionnaireID
LEFT JOIN Keyword k on u.keywordID = k.keywordID
WHERE q.questionnaireID = <insert questionnaireID here>
ORDER BY u.qID

Now this will create a table that looks like this (let's say we have another question with qID = 4 that doesn't have a keyword and a fith question that has
keyword 4)
questionnaireID    qID    keywordID
15                 1      4
15                 2      5
15                 3      6
15                 4      NULL
15                 5      4

There is less repition in this table. If we don't want to see repition or null values at all then we should make 2 seperate queries one will give us a list
of the questionnaire's keywords and the second will give us a list of the questionnaire's questions and we present the two tables seperately.
*/
