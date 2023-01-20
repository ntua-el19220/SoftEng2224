/*Create Data Base schema for intelliQ*/

DROP SCHEMA IF EXISTS intelliqDB;
CREATE SCHEMA intelliqDB;

USE intelliqDB;

/*------------------------------------ ------------------------------------ ------------------------------------*/

/* START OF TABLES HERE */


/* create primary tables tables */
DROP TABLE IF EXISTS Questionnaire;
CREATE TABLE Questionnaire(
	questionnaireID varchar(255) not null, /* Primary key */
	questionnaireTitle varchar(255) not null,
	dateUpdated date null,
	CONSTRAINT PK_Questionnaire PRIMARY KEY (questionnaireID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS Keyword;
CREATE TABLE Keyword(
	keywordID int not null AUTO_INCREMENT, /*primary */
	word varchar(255) not null ,
	questionnaireID varchar(255) not null, /* foreign */
	CONSTRAINT PK_Keyword PRIMARY KEY (keywordID),
	CONSTRAINT FK_QuestionnaireID_Keyword FOREIGN KEY (questionnaireID) REFERENCES Questionnaire(questionnaireID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS User;
CREATE TABLE User(
	userID int not null AUTO_INCREMENT, /*pk */
	CONSTRAINT PK_User PRIMARY KEY (userID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/* create tables with derived keys */


DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    qID varchar(255) not null, /* primary key */
    questionnaireID varchar(255) not null, /* foreign key */
    qtext varchar(255) not null,
    required varchar(10) not null,
    type varchar(10) not null,
    keywordID int null, /* foreign key */

    CONSTRAINT PK_Question PRIMARY KEY (qID),
    CONSTRAINT FK_Questionnaire_ID_Question FOREIGN KEY (questionnaireID) REFERENCES Questionnaire(questionnaireID),
    CONSTRAINT FK_Keyword_ID FOREIGN KEY (keywordID) REFERENCES Keyword(keywordID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `Option`;
CREATE TABLE `Option`(
    optID varchar(255) not null, /* primary key */
    opttxt varchar(255) not null,
    qID varchar(255)  not null, /*foreign key */
    nextqID varchar(255) null, /* null because there might not be e next question */

    CONSTRAINT PK_OPT PRIMARY KEY (optID),
    CONSTRAINT FK_QUestion_ID FOREIGN KEY (qID) REFERENCES Question(qID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS Anonymous;
CREATE TABLE Anonymous(
	userID int not null, /* foreign + pk */

	CONSTRAINT FK_USER_ID_ANONYMOUS FOREIGN KEY (userID) REFERENCES User(userID),
	CONSTRAINT PK_ANONYMOUS PRIMARY KEY (userID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS Identified;
CREATE TABLE Identified(
	userID int not null, /* foreign + pk */
	email varchar(255) not null,/* unique charactersitics */
	username varchar(255) not null,/* unique charactersitics */
	password varchar(255) not null,

	CONSTRAINT FK_USER_ID_IDENTIFIED FOREIGN KEY (userID) REFERENCES User(userID),
	CONSTRAINT UN_EMAIL UNIQUE (email),
	CONSTRAINT UN_USERNAME UNIQUE (username),
	CONSTRAINT PK_IDENTIFIED PRIMARY KEY (userID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS Session;
CREATE TABLE Session(
	session char(4) not null, /* pk */
	userID int not null, /*foreign */
	questionnaireID varchar(255) not null, /*foreign */

	CONSTRAINT FK_QuestionnaireID_SESSION FOREIGN KEY (questionnaireID) REFERENCES Questionnaire(questionnaireID),
	CONSTRAINT FK_USER_ID_SESSION FOREIGN KEY (userID) REFERENCES User(userID),
	CONSTRAINT PK_SESSION PRIMARY KEY (session)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*          Adding timestamp for Query e. operation         */
ALTER TABLE Session
    ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

/*          End of alter taable                             */


DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	session char(4) not null, /*foreign */
	optID varchar(255) not null,/*foreign */
	/* pk is both */

	CONSTRAINT FK_SESSION_ANSWER FOREIGN KEY (session) REFERENCES Session(session) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_OPTID_ANSWER FOREIGN KEY (optID) REFERENCES `Option`(optID),
	CONSTRAINT pk_ANSWER PRIMARY KEY (optID, session)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


/* END OF TABLES

/*------------------------------------ ------------------------------------ ------------------------------------*/

/* START OF INDICES HERE */


/* END OF INDICES HERE */

/*------------------------------------ ------------------------------------ ------------------------------------*/

/*					MAKE USERS
						WITH DIFFERENT PRIVILAGES

													*/

DROP USER IF EXISTS 'User_admin'@'localhost';

DROP USER IF EXISTS 'User_2'@'localhost';


CREATE USER 'User_admin'@'localhost' IDENTIFIED BY 'DBdb11@@';

CREATE USER 'User_2'@'localhost' IDENTIFIED BY 'DBdb22@@';


GRANT ALL ON intelliqDB.* TO 'User_admin'@'localhost';

GRANT SELECT ON intelliqDB.* TO 'User_2'@'localhost';

FLUSH PRIVILEGES;

/*			USERS END			*/

/*------------------------------------ ------------------------------------ ------------------------------------*/


/*			TRIGGERS START HERE			*/

/*			TRIGGERS END HERE			*/


/*------------------------------------ ------------------------------------ ------------------------------------*/
/*              VIEWS START HERE            */


/* view for questionnaire with possible answers */
DROP VIEW IF EXISTS view_Questionnaire;
CREATE VIEW view_Questionnaire AS
SELECT questionnaireTitle,qtext,opttxt
FROM Questionnaire q
         INNER JOIN Question a ON q.questionnaireID = a.questionnaireID
         INNER JOIN `Option` b ON b.qID = a.qID
GROUP BY q.questionnaireID;




/* view session from user */
DROP VIEW IF EXISTS view_Session_answers;
CREATE VIEW view_Session_answers AS
SELECT s.session,questionnaireTitle,qtext,opttxt
FROM Session s
    INNER JOIN Questionnaire q ON s.questionnaireID = q.questionnaireID
    INNER JOIN Answer a ON s.session = a.session
    INNER JOIN `Option` o ON a.optID = o.optID
    INNER JOIN Question ON Question.questionnaireID = q.questionnaireID AND o.qID = Question.qID;
/*              VIEWS END HERE            */


/*------------------------------------ ------------------------------------ ------------------------------------*/

/*              DB PROCEDURES START HERE            */

/*         Admin endpoint 2 --> {baseURL}/admin/questionnaire_upd       */

CREATE DEFINER=`root`@`%` PROCEDURE `quest_upd`(in quest json)
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE j INT DEFAULT 0;
    -- DECLARE quest JSON;

	DECLARE exit handler for sqlexception
    BEGIN
		ROLLBACK;
		resignal;
    END;
    DECLARE exit handler for sqlwarning
    BEGIN
		ROLLBACK;
        resignal;
    END;
    -- SELECT CONVERT(quest_text,  JSON) INTO quest;
	START TRANSACTION;
	-- Retrieve values from JSON
	SET @questionnaireID = JSON_EXTRACT(quest, '$.questionnaireID');
    SET @questionnaireTitle = JSON_EXTRACT(quest, '$.questionnaireTitle');
	INSERT INTO Questionnaire (questionnaireID, questionnaireTitle) VALUES (
		JSON_UNQUOTE(@questionnaireID),
		JSON_UNQUOTE(@questionnaireTitle)
	);
    SET @keywords = JSON_EXTRACT(quest, '$.keywords');
	SET @keywords_length = JSON_LENGTH(@keywords);
	WHILE i < @keywords_length
    DO
		SET @word = JSON_EXTRACT(quest, CONCAT('$.keywords[',i,']'));
        INSERT INTO Keyword (word, questionnaireID) VALUES (
			JSON_UNQUOTE(@word),
            JSON_UNQUOTE(@questionnaireID)
        );
		SELECT i + 1 INTO i;
	END WHILE;
    SET @quests = JSON_EXTRACT(quest, '$.questions');
    SET @quests_length = JSON_LENGTH(@quests);
	SELECT 0 INTO i;
	WHILE i < @quests_length
    DO
		SET @qID = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].qID'));
        SET @qtext = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].qtext'));
        SET @required = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].required'));
        SET @type = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].type'));
		INSERT INTO Question (qID, questionnaireID, qtext, required, type) VALUES (
			JSON_UNQUOTE(@qID),
			JSON_UNQUOTE(@questionnaireID),
            JSON_UNQUOTE(@qtext),
            JSON_UNQUOTE(@required),
            JSON_UNQUOTE(@type)
		);

        SET @options = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].options'));
        SET @options_length = JSON_LENGTH(@options);
		WHILE j < @options_length
		DO

			SET @optID = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].options[',j,'].optID'));
            SET @opttxt = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].options[',j,'].opttxt'));
            SET @nextqID = JSON_EXTRACT(quest, CONCAT('$.questions[',i,'].options[',j,'].nextqID'));
            INSERT INTO `Option` (optID, opttxt, nextqID, qID) VALUES (
				JSON_UNQUOTE(@optID),
                JSON_UNQUOTE(@opttxt),
                JSON_UNQUOTE(@nextqID),
                JSON_UNQUOTE(@qID)
            );
			SELECT j + 1 INTO j;
        END WHILE;
        SELECT 0 INTO j;
		SELECT i + 1 INTO i;
	END WHILE;
    COMMIT;
END


/*              DB PROCEDURES END HERE            */

/*------------------------------------ ------------------------------------ ------------------------------------*/
