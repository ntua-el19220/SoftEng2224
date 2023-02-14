
/*                  Added use Database */
USE intelliqDB;


INSERT INTO Questionnaire (questionnaireID, questionnaireTitle, dateUpdated) VALUES ("QQ000", "Greek Teams", STR_TO_DATE("01/01/2023", '%d/%m/%Y'));
INSERT INTO Questionnaire (questionnaireID, questionnaireTitle, dateUpdated) VALUES ("QQ001", "NBA Teams", STR_TO_DATE("02/01/2023", '%d/%m/%Y'));



/* User_inserts Removed */


INSERT INTO Identified (userID, email, username, password) VALUES (1, "user1@identified.com" , "George", MD5("Baris"));
INSERT INTO Identified (userID, email, username, password) VALUES (2, "user2@identified.com" , "John", MD5("Chatzis"));
INSERT INTO Identified (userID, email, username, password) VALUES (3, "user3@identified.com" , "Minos", MD5("Kountourakis"));



INSERT INTO Anonymous () VALUES ();
INSERT INTO Anonymous () VALUES ();
INSERT INTO Anonymous () VALUES ();

INSERT INTO Identified (email, username, password) VALUES ("admin@identified.com" , "Admin", MD5("Admin123"));

INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (1, "Football" , "QQ000");
INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (2, "Olympiacos" , "QQ000");
INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (3, "Panathinaikos" , "QQ000");
INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (4, "AEK" , "QQ000");

INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (5, "Basketball" , "QQ001");
INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (6, "Golden State Warrios" , "QQ001");
INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (7, "Los Angeles Lakers" , "QQ001");
INSERT INTO Keyword (keywordID, word, questionnaireID) VALUES (8, "Chicago Bulls" , "QQ001");



INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q00" , "QQ000" , "Which is your favourite Greek Football team?", "TRUE", "question", 1);
INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q01" , "QQ000", "Who is your favourite Olympiacos Player", "FALSE", "question", 2);
INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q02" , "QQ000", "Who is your favourite Panathinaikos Player", "FALSE", "question", 3);
INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q03" , "QQ000", "Who is your favourite AEK Player", "FALSE", "question", 4);

INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q04" , "QQ001" , "Which is your favourite NBA team?", "TRUE", "question", 5);
INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q05" , "QQ001" , "Who is your facourite Golden State Warriors player?", "FALSE", "question", 6);
INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q06" , "QQ001" , "Who is your favourite Los Angeles Lakers player?", "FALSE", "question", 7);
INSERT INTO Question (qID, questionnaireID, qtext, required, type, keywordID) VALUES ("Q07" , "QQ001" , "Who is your favourite Chicago Bulls player?", "FALSE", "question", 8);


INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q00A1", "Olympiacos", "Q00", "Q01");
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q00A2" , "Panathinaikos", "Q00", "Q02");
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q00A3", "AEK", "Q00", "Q03");

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q01A1" , "Bouchalakis", "Q01", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q01A2" , "El Arabi", "Q01", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q01A3" , "Valbuena", "Q01", NULL);

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q02A1" , "Kourbelis", "Q02", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q02A2" , "Bernar", "Q02", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q02A3" , "Sporar", "Q02", NULL);

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q03A1" , "Mantalos", "Q03", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q03A2" , "Amrabat", "Q03", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q03A3" , "Araujo", "Q03", NULL);

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q04A1", "Golden State Warriors", "Q04", "Q05");
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q04A2", "Los Angeles Lakers", "Q04", "Q06");
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q04A3", "Chicago Bulls", "Q04", "Q07");

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q05A1" , "Stephen Curry", "Q05", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q05A2" , "Klay Thompson", "Q05", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q05A3" , "Draymond Green", "Q05", NULL);

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q06A1" , "LeBron James", "Q06", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q06A2" , "Rusell Westbrook", "Q06", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q06A3" , "Anthony Davis", "Q06", NULL);

INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q07A1" , "DeMar DeRozan", "Q07", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q07A2" , "Zach LaVine", "Q07", NULL);
INSERT INTO `Option` (optID, opttxt, qID, nextqID) VALUES ("Q07A3" , "Lonzo Ball", "Q07", NULL);



INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAA", 1, "QQ000");
INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAB", 1, "QQ001");

INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAC", 2, "QQ000");
INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAD", 2, "QQ001");

INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAE", 3, "QQ000");
INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAF", 3, "QQ001");

INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAG", 4, "QQ000");
INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAH", 4, "QQ001");

INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAI", 5, "QQ000");
INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAJ", 5, "QQ001");

INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAK", 6, "QQ000");
INSERT INTO Session (session, userID, questionnaireID) VALUES ("AAAL", 6, "QQ001");



INSERT INTO Answer (session, optID) VALUES ("AAAA", "Q00A1");    -- USER 1
INSERT INTO Answer (session, optID) VALUES ("AAAA", "Q01A1");

INSERT INTO Answer (session, optID) VALUES ("AAAB", "Q04A1");    
INSERT INTO Answer (session, optID) VALUES ("AAAB", "Q05A1");

INSERT INTO Answer (session, optID) VALUES ("AAAC", "Q00A2");    -- USER 2
INSERT INTO Answer (session, optID) VALUES ("AAAC", "Q02A2");

INSERT INTO Answer (session, optID) VALUES ("AAAD", "Q04A2");
INSERT INTO Answer (session, optID) VALUES ("AAAD", "Q06A2");

INSERT INTO Answer (session, optID) VALUES ("AAAE", "Q00A3");   -- USER 3
INSERT INTO Answer (session, optID) VALUES ("AAAE", "Q03A3");

INSERT INTO Answer (session, optID) VALUES ("AAAF", "Q04A3");
INSERT INTO Answer (session, optID) VALUES ("AAAF", "Q07A3");

INSERT INTO Answer (session, optID) VALUES ("AAAG", "Q00A1");   -- USER 4
INSERT INTO Answer (session, optID) VALUES ("AAAG", "Q01A2");

INSERT INTO Answer (session, optID) VALUES ("AAAH", "Q04A1");
INSERT INTO Answer (session, optID) VALUES ("AAAH", "Q05A2");

INSERT INTO Answer (session, optID) VALUES ("AAAI", "Q00A2");   -- USER 5
INSERT INTO Answer (session, optID) VALUES ("AAAI", "Q02A1");

INSERT INTO Answer (session, optID) VALUES ("AAAJ", "Q04A2");
INSERT INTO Answer (session, optID) VALUES ("AAAJ", "Q06A3");

INSERT INTO Answer (session, optID) VALUES ("AAAK", "Q00A3");   -- USER 6
INSERT INTO Answer (session, optID) VALUES ("AAAK", "Q03A1");

INSERT INTO Answer (session, optID) VALUES ("AAAL", "Q04A3");
INSERT INTO Answer (session, optID) VALUES ("AAAL", "Q07A2");











