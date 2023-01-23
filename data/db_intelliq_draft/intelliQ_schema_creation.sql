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
DROP PROCEDURE IF EXISTS `quest_upd`;

DELIMETER //
CREATE PROCEDURE `quest_upd`(in quest json)         -- DEFINER=`root`@`%`
BEGIN
	declare i, j int default 0;
    declare questionnaireID, questionnaireTitle, word, qID, qText, required, optID, opttxt, nextqID, type varchar(255);
    declare keywords_length, quests_length, options_length int;
    declare keywords, quests, options, currentQuest, currentOption json;

    -- exception handling
    -- when ever an exception occurred (duplicate_key, null key, not a valid json...) then
    --	rollback transaction and send the error to caller
	declare exit handler for sqlexception
    begin
		rollback;
		resignal;
    end;
	start transaction;															-- start transaction
	set questionnaireID = quest ->> '$.questionnaireID';						-- get questionnaireID
    set questionnaireTitle = quest ->> '$.questionnaireTitle';					-- get questionnaireTitle
    -- insert new questionnaire
	insert into Questionnaire (questionnaireID, questionnaireTitle) values (
		questionnaireID,
		questionnaireTitle
	);
    set keywords = quest ->> '$.keywords';							-- get the json array with keywords
	set keywords_length = json_length(keywords);								-- get the size of json array with keywords
	while i < keywords_length
    do
		set word = json_extract(keywords, concat('$[', i, ']'));				-- get keyword
        -- insert new keyword for this questionnaireID
        insert into Keyword (word, questionnaireID) values (
			word,
            questionnaireID
        );
		select i + 1 into i;													-- increment counter for words
	end while;
    set quests = quest ->> '$.questions';										-- get the json array with questions
    set quests_length = json_length(quests);									-- get the size of json array with questions
    select 0 into i;															-- reset counter for questions
	while i < quests_length
    do
		set currentQuest = json_extract(quests, concat('$[', i, ']'));			-- current question (i)
		set qID = currentQuest ->> '$.qID';
        set qtext = currentQuest ->> '$.qtext';
        set required = currentQuest ->> '$.required';
        set type = currentQuest ->> '$.type';
        -- insert new question (i)
		insert into Question (qID, questionnaireID, qtext, required, type) values (
			qID,
			questionnaireID,
            qtext,
            required,
            type
		);
        set options = currentQuest ->> '$.options';								-- get the json array with options
        set options_length = json_length(options);								-- get the size of json array with options
		WHILE j < options_length
		DO
			set currentOption = json_extract(options, concat('$[', j, ']'));	-- current option (j) for question (i)
			set optID = currentOption ->> '$.optID';
            set opttxt = currentOption ->> '$.opttxt';
            set nextqID = currentOption ->> '$.nextqID';
            -- insert new option (j) for question (i)
            insert into `Option` (optID, opttxt, nextqID, qID) values (
				optID,
                opttxt,
                nextqID,
                qID
            );
			select j + 1 into j;												-- increment counter for options
        end while;
        select 0 into j;														-- reset counter for options
		select i + 1 into i;  													-- increment counter for questions
	end while;
    commit;																		-- commit changes
END //
DELIMITER ;


/*              DB PROCEDURES END HERE            */

/*------------------------------------ ------------------------------------ ------------------------------------*/
