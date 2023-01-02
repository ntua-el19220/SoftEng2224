/*Create Data Base schema for intelliQ*/


CREATE DATABASE intelliqDB;


/* create primary tables tables */

CREATE TABLE Questionnaire(
	questionnaireID varchar(255) not null, /* Primary key */
	questionnaireTitle varchar(255) not null, 
	dateUpdated date null,
	CONSTRAINT PK_Questionnaire PRIMARY KEY (questionnaireID)
);

CREATE TABLE Keyword(
	keywordID int(10) not null, /*primary */
	word varchar(255) not null ,
	questionnaireID varchar(255) not null, /* foreign */
	CONSTRAINT PK_Keyword PRIMARY KEY (keywordID),
	CONSTRAINT FK_QuestionnaireID_Keyword FOREIGN KEY (questionnaireID) REFERENCES Questionnaire(questionnaireID)
);

CREATE TABLE User(
	userID int(10) not null, /*pk */
	CONSTRAINT PK_User PRIMARY KEY (userID)
);

/* create tables with derived keys */


CREATE TABLE Question (
    qID varchar(255) not null, /* primary key */
    questionnaireID varchar(255) not null, /* foreign key */
    qtext varchar(255) not null, 
    required varchar(10) not null,
    type varchar(10) not null,
    keywordID int(10) null, /* foreign key */

    CONSTRAINT PK_Question PRIMARY KEY (qID),
    CONSTRAINT FK_Questionnaire_ID_Question FOREIGN KEY (questionnaireID) REFERENCES Questionnaire(questionnaireID),
    CONSTRAINT FK_Keyword_ID FOREIGN KEY (keywordID) REFERENCES Keyword(keywordID)
);  

CREATE TABLE OPT(
    optID varchar(255) not null, /* primary key */
    opttxt varchar(255) not null,
    qID varchar(255)  not null, /*foreign key */
    nextqID varchar(255) not null, /*UNIIQUE???? */

    CONSTRAINT PK_OPT PRIMARY KEY (optID),
    CONSTRAINT FK_QUestion_ID FOREIGN KEY (qID) REFERENCES Question(qID)
);  

CREATE TABLE Anonymous(
	userID int(10) not null, /* foreign + pk */

	CONSTRAINT FK_USER_ID_ANONYMOUS FOREIGN KEY (userID) REFERENCES User(userID),
	CONSTRAINT PK_ANONYMOUS PRIMARY KEY (userID)

);

CREATE TABLE Identified(
	userID int(10) not null, /* foreign + pk */
	email varchar(255) not null,/* unique charactersitics */
	username varchar(255) not null,/* unique charactersitics */
	password varchar(255) not null,

	CONSTRAINT FK_USER_ID_IDENTIFIED FOREIGN KEY (userID) REFERENCES User(userID),
	CONSTRAINT UN_EMAIL UNIQUE (email),
	CONSTRAINT UN_USERNAME UNIQUE (username), 
	CONSTRAINT PK_IDENTIFIED PRIMARY KEY (userID)
); 


CREATE TABLE SESS(
	sessID char(4) not null, /* pk */
	userID int(10) not null, /*foreign */
	questionnaireID varchar(255) not null, /*foreign */

	CONSTRAINT FK_QuestionnaireID_SESSION FOREIGN KEY (questionnaireID) REFERENCES Questionnaire(questionnaireID),
	CONSTRAINT FK_USER_ID_SESSION FOREIGN KEY (userID) REFERENCES User(userID),
	CONSTRAINT PK_SESSION PRIMARY KEY (sessID)
);

CREATE TABLE Answer(
	sessID char(4) not null, /*foreign */
	optID varchar(255) not null,/*foreign */
	/* pk is both */

	CONSTRAINT FK_SESSION_ANSWER FOREIGN KEY (sessID) REFERENCES SESS(sessID),
	CONSTRAINT FK_OPTID_ANSWER FOREIGN KEY (optID) REFERENCES OPT(optID),
	CONSTRAINT pk_ANSWER PRIMARY KEY (optID, sessID)
);