
DROP TABLE SECURITY_ROLE CASCADE;
DROP TABLE ADMINISTRATOR_ACCOUNT CASCADE;
DROP TABLE SITE CASCADE;
DROP TABLE QUESTION_FORMAT CASCADE;
DROP TABLE MEAL CASCADE;
DROP TABLE AGE_RANGE CASCADE;
DROP TABLE GENDER CASCADE;
DROP TABLE QUESTION_TOPIC CASCADE;
DROP TABLE PARTICIPANT_TYPE CASCADE;
DROP TABLE POTENTIAL_SURVEY_WORD CASCADE;
DROP TABLE UNIT CASCADE;
DROP TABLE ADMINISTRATOR_ROLE CASCADE;
DROP TABLE SURVEY_VERSION CASCADE;
DROP TABLE QUESTION CASCADE;
DROP TABLE SURVEY_WORD CASCADE;
DROP TABLE SUBMITTED_SURVEY CASCADE;
DROP TABLE QUESTION_SELECTION CASCADE;
DROP TABLE PARTICIPANT_RESPONSE CASCADE;
DROP TABLE SURVEY_QUESTION CASCADE;
DROP EXTENSION pgcrypto;


CREATE EXTENSION pgcrypto;


-- create table for Security ROLE
CREATE TABLE SECURITY_ROLE
(
	SECURITY_ROLE_ID SERIAL PRIMARY KEY NOT NULL,
	SECURITY_DESCRIPTION VARCHAR(100) NOT NULL
);


-- create table Administrator Account
CREATE TABLE ADMINISTRATOR_ACCOUNT
(
	ADMINISTRATOR_ACCOUNT_ID SERIAL PRIMARY KEY NOT NULL,
	USERNAME VARCHAR(50) UNIQUE NOT NULL,
	ADMIN_PASSWORD VARCHAR(60) NOT NULL, -- Changed to VARCHAR(50) for hashing
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	ARCHIVED_YN BOOLEAN DEFAULT FALSE NOT NULL,
	DATE_CREATED TIMESTAMP DEFAULT NOW() NOT NULL,
	DATE_MODIFIED TIMESTAMP NULL
);
-- create table for Site
CREATE TABLE SITE
(
	SITE_ID SERIAL PRIMARY KEY NOT NULL,
	SITE_NAME VARCHAR(100) NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	ARCHIVED_YN BOOL DEFAULT FALSE NOT NULL,
	
	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table Question Format
CREATE TABLE QUESTION_FORMAT
(
	QUESTION_FORMAT_ID SERIAL PRIMARY KEY NOT NULL,
	QUESTION_FORMAT_NAME VARCHAR(100) NOT NULL
);

-- create table Meal
CREATE TABLE MEAL
(
	MEAL_ID SERIAL PRIMARY KEY NOT NULL,
	MEAL_NAME VARCHAR(100) NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	ARCHIVED_YN BOOL DEFAULT FALSE NOT NULL,

	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table Age
CREATE TABLE AGE_RANGE
(
	AGE_RANGE_ID SERIAL PRIMARY KEY NOT NULL,
	AGE_RANGE_DESCRIPTION VARCHAR(100) NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	ARCHIVED_YN BOOL DEFAULT FALSE NOT NULL,

	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table Gender
CREATE TABLE GENDER
(
	GENDER_ID SERIAL PRIMARY KEY NOT NULL,
	GENDER_DESCRIPTION VARCHAR(100) NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	ARCHIVED_YN BOOL DEFAULT FALSE NOT NULL,

	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table Question Topic
CREATE TABLE QUESTION_TOPIC
(
	QUESTION_TOPIC_ID SERIAL PRIMARY KEY NOT NULL,
	QUESTION_TOPIC_DESCRIPTION VARCHAR(100) NOT NULL
);

-- create table Participant
CREATE TABLE PARTICIPANT_TYPE
(
	PARTICIPANT_TYPE_ID SERIAL PRIMARY KEY NOT NULL,
	PARTICIPANT_DESCRIPTION VARCHAR(100) NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	ARCHIVED_YN BOOL DEFAULT FALSE NOT NULL,

	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table for Potential Survey Word
CREATE TABLE POTENTIAL_SURVEY_WORD
(
	SURVEY_WORD_ID SERIAL PRIMARY KEY NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	SURVEY_ACCESS_WORD VARCHAR(8) NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ARCHIVED_YN BOOLEAN DEFAULT FALSE NOT NULL,
	
	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table Unit
CREATE TABLE UNIT
(
	UNIT_ID SERIAL PRIMARY KEY NOT NULL,
	UNIT_NUMBER VARCHAR(100) NOT NULL,
	SITE_ID INT NOT NULL,
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	ARCHIVED_YN BOOL DEFAULT FALSE NOT NULL,	

	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID),
	FOREIGN KEY (SITE_ID) REFERENCES SITE (SITE_ID)
);

-- create table Administrator Role
CREATE TABLE ADMINISTRATOR_ROLE
(
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID),
	SECURITY_ROLE_ID INT NOT NULL REFERENCES SECURITY_ROLE (SECURITY_ROLE_ID),
	DATE_MODIFIED TIMESTAMP DEFAULT NOW() NOT NULL,
	
	PRIMARY KEY (ADMINISTRATOR_ACCOUNT_ID, SECURITY_ROLE_ID)
);

-- create table Survey Version
CREATE TABLE SURVEY_VERSION
(
	SURVEY_VERSION_ID SERIAL PRIMARY KEY NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	START_DATE TIMESTAMP DEFAULT NOW() NOT NULL, 
	END_DATE TIMESTAMP NULL,
	
	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID)
);

-- create table Question
CREATE TABLE QUESTION
(
	QUESTION_ID SERIAL PRIMARY KEY NOT NULL,
	ADMINISTRATOR_ACCOUNT_ID INT NOT NULL,
	QUESTION_FORMAT_ID INT NOT NULL, 
	QUESTION_TOPIC_ID INT NOT NULL,
	QUESTION_TEXT VARCHAR(250) NOT NULL,
	DATE_CREATED TIMESTAMP DEFAULT NOW() NOT NULL,
	IS_EXTRA BOOLEAN DEFAULT FALSE NOT NULL,
	
	FOREIGN KEY (ADMINISTRATOR_ACCOUNT_ID) REFERENCES ADMINISTRATOR_ACCOUNT (ADMINISTRATOR_ACCOUNT_ID),
	FOREIGN KEY (QUESTION_FORMAT_ID) REFERENCES QUESTION_FORMAT (QUESTION_FORMAT_ID),
	FOREIGN KEY (QUESTION_TOPIC_ID) REFERENCES QUESTION_TOPIC (QUESTION_TOPIC_ID)
);

--create Table Survey Word
CREATE TABLE SURVEY_WORD
(
	SURVEY_WORD_ID INT REFERENCES POTENTIAL_SURVEY_WORD (SURVEY_WORD_ID) NOT NULL, 
	SITE_ID INT REFERENCES SITE (SITE_ID) NOT NULL,
	DATE_USED TIMESTAMP DEFAULT NOW() NOT NULL,
	
	PRIMARY KEY (SURVEY_WORD_ID, SITE_ID)
);

-- create table Submitted Survey
CREATE TABLE SUBMITTED_SURVEY
(
	SUBMITTED_SURVEY_ID SERIAL PRIMARY KEY NOT NULL,
	SURVEY_VERSION_ID INT NOT NULL,
	UNIT_ID INT NOT NULL,
	MEAL_ID INT NOT NULL,
	PARTICIPANT_TYPE_ID INT NOT NULL,
	AGE_RANGE_ID INT,
	GENDER_ID INT,
	DATE_ENTERED TIMESTAMP DEFAULT NOW() NOT NULL, 
	CONTACT_REQUEST BOOL NOT NULL DEFAULT FALSE,
	CONTACTED BOOL NOT NULL DEFAULT FALSE,
	CONTACT_ROOM_NUMBER VARCHAR(50) NULL,
	CONTACT_PHONE_NUMBER VARCHAR(20) NULL,
	
	FOREIGN KEY (SURVEY_VERSION_ID) REFERENCES SURVEY_VERSION (SURVEY_VERSION_ID),
	FOREIGN KEY (AGE_RANGE_ID) REFERENCES AGE_RANGE (AGE_RANGE_ID),
	FOREIGN KEY (UNIT_ID) REFERENCES UNIT (UNIT_ID),
	FOREIGN KEY (MEAL_ID) REFERENCES MEAL (MEAL_ID),
	FOREIGN KEY (PARTICIPANT_TYPE_ID) REFERENCES PARTICIPANT_TYPE (PARTICIPANT_TYPE_ID),
	FOREIGN KEY (GENDER_ID) REFERENCES GENDER (GENDER_ID)
);

-- create table Question Selection
CREATE TABLE QUESTION_SELECTION
(
	QUESTION_SELECTION_ID SERIAL PRIMARY KEY NOT NULL,
	QUESTION_ID INT NOT NULL,
	QUESTION_SELECTION_TEXT VARCHAR(100) NOT NULL,
	QUESTION_SELECTION_VALUE VARCHAR(100) NOT NULL,
	
	FOREIGN KEY (QUESTION_ID) REFERENCES QUESTION (QUESTION_ID)
);

-- create table Survey Question
CREATE TABLE PARTICIPANT_RESPONSE
(
	SUBMITTED_SURVEY_ID INT NOT NULL REFERENCES SUBMITTED_SURVEY (SUBMITTED_SURVEY_ID),
	QUESTION_ID INT NOT NULL REFERENCES QUESTION (QUESTION_ID),
	PARTICIPANT_ANSWER TEXT NULL,
	
	PRIMARY KEY (SUBMITTED_SURVEY_ID, QUESTION_ID)
);

-- create table Survey Question
CREATE TABLE SURVEY_QUESTION
(
	SURVEY_VERSION_ID INT NOT NULL REFERENCES SURVEY_VERSION (SURVEY_VERSION_ID),
	QUESTION_ID INT NOT NULL REFERENCES QUESTION (QUESTION_ID),
	
	PRIMARY KEY (SURVEY_VERSION_ID, QUESTION_ID)
);

-- Create Webmaster
INSERT INTO ADMINISTRATOR_ACCOUNT (USERNAME, ADMIN_PASSWORD, FIRST_NAME, LAST_NAME, DATE_CREATED, DATE_MODIFIED)
VALUES ('webmaster', crypt('password', gen_salt('bf')), 'Web', 'Master', Now(), NOW());
INSERT INTO ADMINISTRATOR_ACCOUNT (USERNAME, ADMIN_PASSWORD, FIRST_NAME, LAST_NAME, DATE_CREATED, DATE_MODIFIED)
VALUES ('ggerry', crypt('SecretPassword123', gen_salt('bf')), 'Garry', 'Gerry', Now(), NOW());


--Insert security roles
INSERT INTO security_role (security_description)
VALUES ('Standard Administrator');
INSERT INTO security_role (security_description)
VALUES ('Master Administrator');


--assign webmaster to Master ADministrator role
INSERT INTO ADMINISTRATOR_ROLE (ADMINISTRATOR_ACCOUNT_ID, SECURITY_ROLE_ID, DATE_MODIFIED)
VALUES (1, 2, NOW());
INSERT INTO ADMINISTRATOR_ROLE (ADMINISTRATOR_ACCOUNT_ID, SECURITY_ROLE_ID, DATE_MODIFIED)
VALUES (2,1,NOW());

--create misericordia's site
INSERT INTO SITE (SITE_NAME, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Misericordia Hospital', Now(), 1);

--creates Misericordia's units
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('8E', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('7E', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('5W', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('7W', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('6E', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('6W', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('5E', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('3E', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('3N', 1, Now(), 1);
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('ED', 1, Now(), 1);
--for those without a unit (nonpatients)
INSERT INTO UNIT (UNIT_NUMBER, SITE_ID, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Not Applicable', 1, Now(), 1);

--create potential survey words
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'sunshine', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'flower', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'supper', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'sleepy', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'hungry', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'happy', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'orange', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'friend', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'spring', Now());
INSERT INTO POTENTIAL_SURVEY_WORD(ADMINISTRATOR_ACCOUNT_ID, SURVEY_ACCESS_WORD, DATE_MODIFIED)
VALUES (1, 'circle', Now());

--additional 1588 generated words
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mystery',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('enough',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('concept',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('existence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('coin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('glad',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('asked',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hours',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('suspect',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('allure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exact',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('loan',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lock',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('logo',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('long',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('look',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lord',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('loss',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lost',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('love',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('luck',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('made',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mail',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('main',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('make',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('male',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('many',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('Mark',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mass',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('matt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('meal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mean',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('meat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('meet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('menu',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mere',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mike',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mile',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('milk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mind',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('miss',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mode',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mood',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('moon',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('more',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('most',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('move',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('much',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('must',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('name',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('navy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('near',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('neck',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('need',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('news',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('next',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nick',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('none',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('note',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('okay',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('once',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('only',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('onto',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('open',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('oral',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('over',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pace',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pack',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('page',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('paid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pair',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('palm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('park',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('part',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pass',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('past',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('path',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('peak',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pick',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pink',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pipe',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plan',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('play',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plot',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plug',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plus',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('poll',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pool',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('poor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('port',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('post',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pull',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('push',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('race',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rail',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rank',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rare',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('read',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('real',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rest',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rich',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ride',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ring',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('risk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('road',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rock',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('role',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('roll',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('roof',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('room',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('root',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rule',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rush',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ruth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('safe',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('said',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sake',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sale',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('salt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('same',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sand',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('save',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seek',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seem',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('self',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sell',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('send',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sept',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ship',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shop',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shot',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('show',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shut',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('side',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sign',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('site',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('size',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('skin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('slip',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('slow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('snow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('soft',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('soil',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sold',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sole',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('some',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('song',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('soon',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sort',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('soul',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spot',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('star',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stay',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('step',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stop',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('such',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('suit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('take',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tale',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('talk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tank',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tape',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('task',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('team',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tech',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tell',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tend',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('term',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('test',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('text',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('than',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('that',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('them',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('then',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('they',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('this',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thus',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('till',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('time',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tiny',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('told',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('toll',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tony',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('took',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tool',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tour',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('town',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tree',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('trip',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('true',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tune',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('turn',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('twin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('type',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('upon',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('used',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('user',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vast',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('very',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('view',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vote',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wait',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wake',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('walk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('want',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('warm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wash',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wave',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ways',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('week',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('well',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('went',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('were',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('west',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('what',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('when',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('whom',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wide',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wife',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wild',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('will',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wind',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wire',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wish',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('with',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wood',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('word',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wore',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('work',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('yard',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('yeah',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('year',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('your',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('zero',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('zone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('able',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('acid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('aged',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('also',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('area',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('army',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('away',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('baby',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('back',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ball',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('band',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bank',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('base',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bath',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('beat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('been',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('beer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bell',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('belt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('best',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bird',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('blow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('blue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('boat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('body',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bomb',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bond',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('book',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('boom',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('born',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('boss',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('both',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bowl',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bulk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('burn',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bush',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('busy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('call',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('calm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('came',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('camp',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('card',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('care',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('case',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cash',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cast',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cell',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('chat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('chip',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('city',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('club',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('coal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('coat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('code',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cold',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('come',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cook',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cool',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cope',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('copy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('core',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cost',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('crew',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('crop',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dark',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('data',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('date',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dawn',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('days',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('deal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dean',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('debt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('deep',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('deny',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('desk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dial',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('diet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('disc',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('disk',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('does',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('done',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('door',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('down',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('draw',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drew',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drop',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drug',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dual',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('duke',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dust',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('duty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('each',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('earn',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ease',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('east',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('easy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('edge',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('else',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('even',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ever',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('face',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fact',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fail',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fair',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('farm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fast',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('feed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('feel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('feet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fell',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('felt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('file',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('film',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('find',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fire',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('firm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fish',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('five',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('flat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('flow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('food',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('foot',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ford',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('form',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fort',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('four',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('free',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('from',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fuel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('full',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fund',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('game',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gave',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gene',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gift',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('girl',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('give',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('glad',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('goal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('goes',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gold',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('Golf',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('good',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gray',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grew',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grey',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gulf',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hair',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('half',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hand',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hang',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hard',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('harm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('have',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('head',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hear',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('heat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('held',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('help',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('here',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hero',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('high',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hire',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hold',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hole',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('holy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('home',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hope',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('host',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hour',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('huge',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hunt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hurt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('idea',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('inch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('into',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('iron',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('item',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('join',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('jump',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('jury',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('just',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('keen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('keep',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('kent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('kept',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('kick',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('kill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('kind',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('king',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('knee',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('knew',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('know',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lack',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lady',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('laid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lake',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('land',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lane',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('last',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('late',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lead',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('left',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('less',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('life',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lift',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('like',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('line',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('link',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('list',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('live',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('load',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drawn',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dream',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dress',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drink',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drive',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('drove',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('eager',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('early',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('earth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('eight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('elite',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('empty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('enemy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('enjoy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('enter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('entry',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('equal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('error',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('event',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('every',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exact',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exist',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('extra',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('faith',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('false',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fault',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fiber',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('field',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fifth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fifty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('final',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('first',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fixed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('flash',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fleet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('floor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fluid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('focus',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('force',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('forth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('forty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('forum',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('found',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('frame',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fraud',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fresh',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('front',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fruit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fully',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('funny',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('giant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('given',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('glass',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('globe',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('going',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grade',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grand',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grass',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('great',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('green',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('gross',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('group',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grown',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('guard',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('guess',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('guest',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('guide',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('heart',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('heavy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('horse',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hotel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('house',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('human',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ideal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('image',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('index',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('inner',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('input',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('issue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('joint',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('judge',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('known',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('label',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('large',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('laser',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('later',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('laugh',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('layer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('learn',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lease',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('least',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('leave',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('legal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('level',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('light',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('limit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('links',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lives',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('local',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('logic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('loose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lower',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lucky',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lunch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lying',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('magic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('major',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('maker',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('march',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('maria',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('match',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('maybe',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mayor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('meant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('media',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('metal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('might',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('minor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('minus',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mixed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('model',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('money',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('month',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('moral',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('motor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mount',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mouse',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mouth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('movie',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('music',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('needs',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('never',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('newly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('night',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('noise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('north',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('noted',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('novel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nurse',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('occur',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ocean',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('offer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('often',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('order',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('other',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ought',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('paint',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('panel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('paper',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('party',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('peace',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('phase',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('phone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('photo',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('piece',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pilot',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pitch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('place',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plane',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('point',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pound',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('power',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('press',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('price',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pride',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prime',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('print',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prior',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prize',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('proof',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('proud',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prove',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('queen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('quick',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('quiet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('quite',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('radio',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('raise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('range',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rapid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ratio',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reach',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ready',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('refer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('right',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rival',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('river',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('robin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rough',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('round',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('route',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('royal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rural',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('scale',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('scene',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('scope',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('score',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sense',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('serve',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seven',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shape',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('share',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sharp',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sheet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shelf',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shell',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shift',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shirt',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('short',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shown',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('since',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sixth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sixty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sized',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('skill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sleep',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('slide',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('small',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('smart',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('smile',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('smith',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('smoke',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('solid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('solve',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sorry',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sound',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('south',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('space',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spare',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('speak',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('speed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spend',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('split',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spoke',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sport',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('staff',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stake',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stand',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('start',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('state',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('steam',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('steel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stick',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('still',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stock',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stood',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('store',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('storm',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('story',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strip',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stuck',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('study',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stuff',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('style',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sugar',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('suite',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('super',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sweet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('table',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taken',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taste',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taxes',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('teach',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('teeth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thank',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('their',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('theme',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('there',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('these',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thick',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('think',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('third',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('those',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('three',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('threw',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('throw',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('times',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tired',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('title',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('today',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('topic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('total',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('touch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tough',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tower',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('track',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('trade',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('train',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('treat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('trend',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('trial',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tried',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tries',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('truck',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('truly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('trust',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('truth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('twice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('under',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('undue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('union',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('until',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('upper',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('upset',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('urban',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('usage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('usual',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('valid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('value',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('video',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('virus',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('visit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vital',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('voice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('waste',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('watch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('water',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wheel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('where',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('which',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('while',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('white',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('whole',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('whose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('woman',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('women',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('world',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('worth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('would',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wound',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('write',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wrote',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('yield',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('young',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('youth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('labour',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('latest',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('latter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('launch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lawyer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('leader',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('league',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('leaves',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('legacy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('length',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lesson',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('letter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lights',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('likely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('linked',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('liquid',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('listen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('little',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('living',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('losing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lucent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('luxury',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mainly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('making',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('manage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('manner',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('manual',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('margin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('marine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('marked',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('market',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('master',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('matter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mature',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('medium',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('member',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('memory',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mental',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('merely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('merger',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('method',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('middle',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('miller',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mining',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('minute',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mirror',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mobile',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('modern',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('modest',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('module',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('moment',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mostly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mother',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('motion',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('moving',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('museum',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mutual',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('myself',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('narrow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nation',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('native',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nature',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nearby',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nearly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nights',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nobody',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('normal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('notice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('notion',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('number',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('object',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('obtain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('office',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('offset',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('online',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('option',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('origin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('output',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('packed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('palace',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('parent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('partly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('patent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('people',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('period',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('permit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('person',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('phrase',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('picked',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('planet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('player',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('please',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('plenty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pocket',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('police',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('policy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prefer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pretty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prince',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('profit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('proper',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('proven',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('public',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pursue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('raised',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('random',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rarely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rather',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rating',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reader',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('really',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reason',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('recall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('recent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('record',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reduce',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reform',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('regard',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('regime',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('region',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('relate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('relief',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('remain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('remote',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('remove',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('repair',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('repeat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('replay',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('report',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rescue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('resort',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('result',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('retail',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('retain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('return',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reveal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('review',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reward',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('riding',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rising',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('robust',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ruling',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('safety',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('salary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sample',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('saving',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('saying',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('school',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('screen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('search',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('season',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('second',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('secret',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sector',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('secure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seeing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('select',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seller',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('senior',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('series',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('server',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('settle',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('should',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('signal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('signed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('silent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('silver',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('simple',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('simply',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('single',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sister',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('slight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('smooth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('social',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('solely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sought',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('source',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('soviet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('speech',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spirit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spoken',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spread',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('square',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('status',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('steady',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stolen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stream',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('street',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strict',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strike',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('string',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strong',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('struck',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('studio',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('submit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sudden',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('summer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('summit',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('supply',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('surely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('survey',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('switch',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('symbol',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('system',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taking',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('talent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('target',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taught',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tenant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tender',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tennis',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thanks',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('theory',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thirty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('though',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thrown',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ticket',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('timely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('timing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tissue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('toward',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('travel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('treaty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('trying',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('twelve',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('twenty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unique',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('united',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unless',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unlike',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('update',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('useful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('valley',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('varied',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vendor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('versus',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vision',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('visual',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('volume',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('walker',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wealth',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('weekly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('weight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('window',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('winner',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('winter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('within',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wonder',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('worker',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wright',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('writer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('yellow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('absolute',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('abstract',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('academic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('accepted',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('accident',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('accuracy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('accurate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('achieved',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('activity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('actually',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('addition',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('adequate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('adjacent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('adjusted',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('advanced',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('advisory',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('advocate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('affected',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('aircraft',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('alliance',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('although',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('analysis',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('announce',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('anything',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('anywhere',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('apparent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('appendix',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('approach',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('approval',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('argument',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('artistic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('assembly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('assuming',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('athletic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('attached',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('attitude',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('attorney',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('audience',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('autonomy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('aviation',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bachelor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('baseball',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bathroom',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('becoming',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('birthday',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('boundary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('breaking',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('breeding',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('building',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('bulletin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('business',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('calendar',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('campaign',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('capacity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('casualty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('catching',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('category',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cautious',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cellular',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('chairman',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('champion',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('chemical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('children',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('circular',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('civilian',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('clearing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('clinical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('clothing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('collapse',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('colonial',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('colorful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('commence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('commerce',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('complain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('complete',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('composed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('compound',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('comprise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('computer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('conclude',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('concrete',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('conflict',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('confused',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('congress',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('consider',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('constant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('consumer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('continue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('contract',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('contrary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('contrast',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('convince',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('corridor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('coverage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('covering',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('creation',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('creative',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('critical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('crossing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('cultural',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('currency',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('customer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('database',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('daughter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('daylight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('deadline',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('deciding',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('decision',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('decrease',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('deferred',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('definite',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('delicate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('delivery',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('describe',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('designer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('detailed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dialogue',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('diameter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('directly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('director',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('disclose',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('discount',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('discover',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('disorder',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('disposal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('distance',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('distinct',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('district',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('division',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('doctrine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('document',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('domestic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dominant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dominate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('doubtful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dramatic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dressing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dropping',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('duration',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('dynamics',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('earnings',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('economic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('educated',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('efficacy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('eighteen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('election',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('electric',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('eligible',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('emerging',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('emphasis',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('employee',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('endeavor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('engaging',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('engineer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('enormous',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('entirely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('entrance',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('envelope',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('equality',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('equation',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('estimate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('evaluate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('eventual',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('everyday',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('everyone',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('evidence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exchange',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exciting',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exercise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('exposure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('extended',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('external',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('facility',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('familiar',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('featured',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('feedback',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('festival',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('finished',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('firewall',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('flagship',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('flexible',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('floating',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('football',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('foothill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('forecast',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('foremost',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('formerly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fourteen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('fraction',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('franklin',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('frequent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('friendly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('frontier',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('function',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('generate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('generous',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('genomics',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('goodwill',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('governor',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('graduate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('graphics',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('grateful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('guardian',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('guidance',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('handling',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hardware',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('heritage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('highland',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('historic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('homeless',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('homepage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('hospital',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('humanity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('identify',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('identity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ideology',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('imperial',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('incident',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('included',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('increase',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('indicate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('indirect',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('industry',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('informal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('informed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('inherent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('initiate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('innocent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('inspired',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('instance',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('integral',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('intended',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('interact',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('interest',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('interior',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('internal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('interval',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('intimate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('intranet',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('invasion',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('involved',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('isolated',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('judgment',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('judicial',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('junction',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('keyboard',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('landlord',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('language',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('laughter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('learning',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('leverage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lifetime',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('lighting',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('likewise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('limiting',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('literary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('location',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('magazine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('magnetic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('maintain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('majority',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('marginal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('marriage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('material',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('maturity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('maximize',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('meantime',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('measured',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('medicine',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('medieval',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('memorial',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('merchant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('midnight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('military',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('minimize',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('minister',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ministry',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('minority',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mobility',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('modeling',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('moderate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('momentum',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('monetary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('moreover',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mortgage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mountain',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('mounting',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('movement',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('multiple',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('national',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('negative',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('nineteen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('northern',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('notebook',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('numerous',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('observer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('occasion',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('offering',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('official',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('offshore',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('operator',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('opponent',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('opposite',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('optimism',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('optional',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ordinary',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('organize',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('original',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('overcome',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('overhead',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('overseas',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('overview',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('painting',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('parallel',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('parental',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('patented',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('patience',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('peaceful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('periodic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('personal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('persuade',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('petition',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('physical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pipeline',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('platform',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pleasant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pleasure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('politics',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('portable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('portrait',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('position',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('positive',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('possible',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('powerful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('practice',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('precious',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pregnant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('presence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('preserve',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pressing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pressure',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('previous',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('princess',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('printing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('priority',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('probable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('probably',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('producer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('profound',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('progress',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('property',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('proposal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('prospect',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('protocol',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('provided',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('provider',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('province',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('publicly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('purchase',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('pursuant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('quantity',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('question',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rational',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reaction',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('received',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('receiver',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('recovery',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('regional',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('register',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('relation',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('relative',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('relevant',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reliable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reliance',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('remember',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('renowned',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('repeated',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reporter',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('republic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('required',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('research',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('reserved',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('resident',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('resigned',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('resource',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('response',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('restrict',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('revision',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('rigorous',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('romantic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sampling',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('scenario',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('schedule',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('scrutiny',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('seasonal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('secondly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('security',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sensible',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sentence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('separate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sequence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shipping',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shortage',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('shoulder',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('simplify',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('situated',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('slightly',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('software',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('solution',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('somebody',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('somewhat',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('southern',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('speaking',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('specific',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('spectrum',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sporting',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('standard',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('standing',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('standout',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sterling',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('straight',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strategy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('strength',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('striking',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('stunning',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('suburban',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('suitable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('superior',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('supposed',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('surgical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('surprise',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('survival',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sweeping',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('swimming',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('symbolic',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('sympathy',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tactical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tailored',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('takeover',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tangible',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taxation',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('taxpayer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('teaching',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tendency',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('terminal',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thinking',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thirteen',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thorough',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('thousand',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('together',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tomorrow',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('touching',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tracking',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('training',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('transfer',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('traveled',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('treasury',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('triangle',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('tropical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('turnover',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('ultimate',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('umbrella',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('universe',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unlawful',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('unlikely',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('valuable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('variable',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('vertical',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('victoria',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('violence',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('volatile',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('warranty',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('weakness',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('weighted',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('whatever',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('whenever',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wherever',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wildlife',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('wireless',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('withdraw',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('woodland',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('workshop',1);
INSERT INTO potential_survey_word(survey_access_word,administrator_account_id) VALUES ('yourself',1);



--create question formats
INSERT INTO QUESTION_FORMAT(QUESTION_FORMAT_NAME)
VALUES ('choice');
INSERT INTO QUESTION_FORMAT(QUESTION_FORMAT_NAME)
VALUES ('text');
--questions whose answers are also stored directly on the submitted_survey
--technically still a "choice" format 
INSERT INTO QUESTION_FORMAT(QUESTION_FORMAT_NAME)
VALUES ('demo');
--not really a question. 
INSERT INTO QUESTION_FORMAT(QUESTION_FORMAT_NAME)
VALUES ('header');
--not really a question; exits header format
INSERT INTO QUESTION_FORMAT(QUESTION_FORMAT_NAME)
VALUES ('exitheader');


--create question topics
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Variety');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Taste');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Temperature');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Appearance');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Staff Helpfulness');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Portion Size');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Diet Requirements');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Overall Experience');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Comment');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('None');
--
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Age Range');
INSERT INTO QUESTION_TOPIC(QUESTION_TOPIC_DESCRIPTION)
VALUES('Gender');

--create questions
--first the original questions
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 4, 10, 'During this hospital stay, how would you describe the following features of your meals?', Now(), false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 1, 'The variety of food in your daily meals',Now(), false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 2, 'The taste and flavour of your meals', Now(),false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 3, 'The temperature of your hot food', Now(),false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 4, 'The overall appearance of your meal', Now(),false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 5, 'The helpfulness of the staff who deliver your meals',Now(), false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 5, 10, '',Now(), false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 6, 'How satisfied are you with the portion sizes of your meals?',Now(), false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 7, 'Do your meals take into account your specific diet requirements?',Now(), false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 1, 8, 'Overall, how would you rate your meal experience?', Now(),false);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 2, 9, 'Is there anything else you would like to share about your meal experience?',Now(), false);

--demographic questions -- UPDATE-March 15, demographic questions no longer needed, will be hardcoded
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 3, 12, 'Gender:',Now(), true);
INSERT INTO QUESTION(ADMINISTRATOR_ACCOUNT_ID, QUESTION_FORMAT_ID, QUESTION_TOPIC_ID, QUESTION_TEXT, DATE_CREATED, IS_EXTRA)
VALUES (1, 3, 11, 'Age Range:',Now(), true);

--create question selections
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (2, 'Very Good','Very Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (2, 'Good','Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (2, 'Fair','Fair');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (2, 'Poor','Poor');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (2, 'Don''t Know/No Opinion','Don''t Know/No Opinion');

INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (3, 'Very Good','Very Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (3, 'Good','Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (3, 'Fair','Fair');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (3, 'Poor','Poor');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (3, 'Don''t Know/No Opinion','Don''t Know/No Opinion');

INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (4, 'Very Good','Very Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (4, 'Good','Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (4, 'Fair','Fair');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (4, 'Poor','Poor');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (4, 'Don''t Know/No Opinion','Don''t Know/No Opinion');

INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (5, 'Very Good','Very Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (5, 'Good','Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (5, 'Fair','Fair');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (5, 'Poor','Poor');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (5, 'Don''t Know/No Opinion','Don''t Know/No Opinion');

INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (6, 'Very Good','Very Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (6, 'Good','Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (6, 'Fair','Fair');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (6, 'Poor','Poor');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (6, 'Don''t Know/No Opinion','Don''t Know/No Opinion');

INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (8, 'Portion sizes are too small','Portion sizes are too small');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (8, 'Portion sizes are just right','Portion sizes are just right');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (8, 'Portion sizes are too large','Portion sizes are too large');

INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (9, 'Always','Always');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (9, 'Usually','Usually');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (9, 'Occasionally','Occasionally');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (9, 'Never','Never');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (9, 'I do not have any specific dietary requirements','I do not have any specific dietary requirements');


--UPDATE march 15, removed 6th choice (terrible) to match other questions
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (10, 'Very Good','Very Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (10, 'Good','Good');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (10, 'Fair','Fair');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (10, 'Poor','Poor');
INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
VALUES (10, 'Very Poor','Very Poor');

-- --
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (12, 'Prefer not to answer','1');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (12, 'Male','2');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (12, 'Female','3');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (12, 'Other','4');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (12, 'Prefer not to answer','4');

-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (13, 'Under 18 years','1');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (13, '18 to 34 years','2');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (13, '35 to 54 years','3');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (13, '55 to 74 years','4');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (13, 'Over 75 years','5');
-- INSERT INTO QUESTION_SELECTION(QUESTION_ID, QUESTION_SELECTION_TEXT, QUESTION_SELECTION_VALUE)
-- VALUES (13, 'Prefer not to answer','6');


--create the empty survey version
INSERT INTO SURVEY_VERSION(ADMINISTRATOR_ACCOUNT_ID, START_DATE)
VALUES (1, Now());

--create survey questions (associate the questions with the survey version)
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,1);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,2);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,3);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,4);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,5);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,6);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,7);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,8);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,9);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,10);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,11);

INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,12);
INSERT INTO SURVEY_QUESTION(SURVEY_VERSION_ID, QUESTION_ID)
VALUES (1,13);

--create meals
INSERT INTO MEAL(MEAL_NAME, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Breakfast', Now(), 1);
INSERT INTO MEAL(MEAL_NAME, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Lunch', Now(), 1);
INSERT INTO MEAL(MEAL_NAME, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Supper', Now(), 1);
INSERT INTO MEAL(MEAL_NAME, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Tea/Snack', Now(), 1);
--value for no selection (?)
INSERT INTO MEAL(MEAL_NAME, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Unspecified', Now(), 1);

--create participant types
INSERT INTO PARTICIPANT_TYPE(PARTICIPANT_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES('Patient', Now(), 1);
INSERT INTO PARTICIPANT_TYPE(PARTICIPANT_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES('Non-Patient', Now(),1);

--create age-ranges
INSERT INTO AGE_RANGE(AGE_RANGE_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Prefer not to Answer', Now(), 1);
INSERT INTO AGE_RANGE(AGE_RANGE_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Under 18 years', Now(), 1);
INSERT INTO AGE_RANGE(AGE_RANGE_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('18 to 34 years', Now(), 1);
INSERT INTO AGE_RANGE(AGE_RANGE_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('35 to 54 years', Now(), 1);
INSERT INTO AGE_RANGE(AGE_RANGE_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('55 to 74 years', Now(), 1);
INSERT INTO AGE_RANGE(AGE_RANGE_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Over 75 years', NOw(), 1);

--create genders
INSERT INTO GENDER(GENDER_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Prefer not to Answer', Now(), 1);
INSERT INTO GENDER(GENDER_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Male', Now(), 1);
INSERT INTO GENDER(GENDER_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Female', Now(), 1);
INSERT INTO GENDER(GENDER_DESCRIPTION, DATE_MODIFIED, ADMINISTRATOR_ACCOUNT_ID)
VALUES ('Other', Now(), 1);



----------------------------------------------------
--create dummy submitted surveys
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 1, 1, 1, 3,3,Now(), true, false, '101', '7805551234');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 2, 3, 1, 1,1,Now(), true, false, '222', '8883333');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 3, 3, 2, 4,2,Now(), false, false, '', '');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 4, 2, 1, 2,4,Now(), true, false, '333', '1110000');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 5, 4, 1, 5,2,Now(), true, false, '000', '4444444');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 6, 2, 2, 2,2,Now(), true, false, '2', '2222222');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 7, 3, 1, 3,3,Now(), true, false, '3', '3333333');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 8, 5, 2, 4,4,Now(), false, false, '', '');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 9, 1, 2, 1,4,Now(), false, false, '', '');
INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED,
							CONTACT_REQUEST, CONTACTED, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
VALUES (1, 10, 2, 1, 1,1,Now(), false ,false, '111', '1111111');


--create dummy participant responses

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,2,'Very Good');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,3,'Very Good');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,4,'Very Good');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,5,'Poor');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,6,'Very Poor');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,8,'Too Small');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,9,'Never');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,10,'5');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,11,'The meal was great and everything tasted excellent. Loved the coffee.');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (1,12,'3');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (1,13,'3');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (2,11,'Wooohoo');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (2,12,'1');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (2,13,'1');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (3,11,'');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (3,12,'2');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (3,13,'4');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (4,11,'');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (4,12,'4');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (4,13,'2');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (5,11,'');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (5,12,'2');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (5,13,'5');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (6,11,'i am bored');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (6,12,'2');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (6,13,'2');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,2,'Fair');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,3,'Fair');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,4,'Fair');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,5,'Fair');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,6,'Fair');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,8,'Just Right');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,9,'Usually');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,10,'4');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (7,11,'have you heard of salt?');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (7,12,'3');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (7,13,'3');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (8,11,'d');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (8,12,'4');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (8,13,'4');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (9,11,'I visited Misericordia Community Hospital the day Edmonton made headlines for being colder than both the North and the South Pole.

The temperature was a mind and body-numbing 37 C with the wind chill and yet Misericordia was doing a booming business. 

Maybe these people, having been cooped up with relatives too long during the holidays, needed a change of scenery.

Maybe they could not stomach the thought of one more turkey-based meal. Or, maybe, being winter-hardy Edmontonians, they just figured there was no better time to venture out for some crispy eel and a pint of Innis & Gunn. 

Whatever the reason, the cozy hospital located at 16940 87 Ave NW had a lovely, lively, post-Christmas vibe.');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (9,12,'4');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (9,13,'1');

INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,2,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,3,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,4,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,5,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,6,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,8,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,9,'');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,10,'3');
INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
VALUES (10,11,'Wooohoo');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (10,12,'1');
--INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
--VALUES (10,13,'1');


---Add functions below

--create submit_survey function 
CREATE or REPLACE FUNCTION submit_survey (
    survey_version_id_param INTEGER,
    unit_id_param INTEGER,
    meal_id_param INTEGER, 
    participant_type_id_param INTEGER,
    age_range_id_param INTEGER,
    gender_id_param INTEGER,
    contact_request_param BOOL,
    contact_room_number_param VARCHAR(50),
    contact_phone_number_param VARCHAR(20),
    Q1AResponse_param TEXT,
    Q1BResponse_param TEXT,
    Q1CResponse_param TEXT,
    Q1DResponse_param TEXT,
    Q1EResponse_param TEXT,
    Q2Response_param TEXT,
    Q3Response_param TEXT,
    Q4Response_param TEXT,
    Q5Response_param TEXT
)
RETURNS
    VOID AS $$
DECLARE
    newSubmittedSurveyID INTEGER;
BEGIN

    INSERT INTO SUBMITTED_SURVEY(SURVEY_VERSION_ID, UNIT_ID, MEAL_ID, PARTICIPANT_TYPE_ID, AGE_RANGE_ID, GENDER_ID, DATE_ENTERED, CONTACT_REQUEST, CONTACT_ROOM_NUMBER, CONTACT_PHONE_NUMBER)
    VALUES (survey_version_id_param, unit_id_param, meal_id_param, participant_type_id_param, age_range_id_param, gender_id_param, NOW(), contact_request_param, contact_room_number_param, contact_phone_number_param);

    SELECT INTO newSubmittedSurveyID
        MAX(submitted_survey_id)
    FROM
        submitted_survey;


    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 2, Q1AResponse_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 3, Q1BResponse_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 4, Q1CResponse_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 5, Q1DResponse_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 6, Q1EResponse_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 8, Q2Response_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 9, Q3Response_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 10, Q4Response_param);

    INSERT INTO PARTICIPANT_RESPONSE(SUBMITTED_SURVEY_ID,QUESTION_ID,PARTICIPANT_ANSWER)
    VALUES (newSubmittedSurveyID, 11, Q5Response_param);

END; $$
LANGUAGE PLPGSQL;

-- Create password_is_valid function
CREATE OR REPLACE FUNCTION password_is_valid (
	username_param VARCHAR(50), 
	password_param VARCHAR(60))
RETURNS BOOLEAN AS $$
	DECLARE isValid BOOLEAN;
BEGIN
	IF username_param = '' OR username_param IS NULL OR password_param = '' OR password_param IS NULL THEN
		isValid = FALSE;
	ELSE	
		SELECT INTO isValid
		(admin_password = crypt(password_param, admin_password))
		FROM administrator_account
		WHERE username = username_param;
	END IF;
	RETURN isValid;
END; $$
LANGUAGE PLPGSQL;

-- Create add_user function
CREATE OR REPLACE FUNCTION add_user (
	username_param VARCHAR(50), 
	password_param VARCHAR(60),
	firstname_param VARCHAR(50),
	lastname_param VARCHAR(50),
	securityid_param INTEGER)
RETURNS VARCHAR(50) AS $$
DECLARE
	userID INTEGER;
	createdUsername VARCHAR(50);
BEGIN
	INSERT INTO administrator_account (username, admin_password, first_name, last_name, date_created)
	VALUES (username_param, crypt(password_param,gen_salt('bf')), firstname_param, lastname_param, NOW());
	
	SELECT administrator_account_id INTO userID
	FROM administrator_account
	WHERE username = username_param;
	
	INSERT INTO administrator_role (administrator_account_id, security_role_id, date_modified)
	VALUES (userID, securityid_param, NOW());
	
	SELECT username INTO createdUsername
	FROM administrator_account
	WHERE administrator_account_id = userID;
	
	RETURN createdUsername;
END; $$
LANGUAGE PLPGSQL;

-- Create update_user_with_password function
CREATE OR REPLACE FUNCTION update_user_with_password (
	username_param VARCHAR(50), 
	password_param VARCHAR(60),
	firstname_param VARCHAR(50),
	lastname_param VARCHAR(50),
	archived_yn_param BOOLEAN,
	securityid_param INTEGER)
RETURNS VARCHAR(50) AS $$
DECLARE
	userID INTEGER;
	updatedUser VARCHAR(50);
BEGIN
	UPDATE
		administrator_account
	SET
		admin_password = crypt(password_param,gen_salt('bf')),
		first_name = firstname_param, 
		last_name = lastname_param,
		archived_yn = archived_yn_param,
		date_modified = NOW()
	WHERE
		username = username_param;
	
	SELECT administrator_account_id INTO userID
	FROM administrator_account
	WHERE username = username_param;
	
	UPDATE
		administrator_role
	SET
		security_role_id = securityid_param,
		date_modified = NOW()
	WHERE
		administrator_account_id = userID;
	
	SELECT username INTO updatedUser
	FROM administrator_account
	WHERE administrator_account_id = userID;
	
	RETURN updatedUser;
END; $$
LANGUAGE PLPGSQL;

-- Create update_user_with_password function
CREATE OR REPLACE FUNCTION update_user_without_password (
	username_param VARCHAR(50), 
	firstname_param VARCHAR(50),
	lastname_param VARCHAR(50),
	archived_yn_param BOOLEAN,
	securityid_param INTEGER)
RETURNS VARCHAR(50) AS $$
DECLARE
	userID INTEGER;
	updatedUser VARCHAR(50);
BEGIN
	UPDATE
		administrator_account
	SET
		first_name = firstname_param, 
		last_name = lastname_param,
		archived_yn = archived_yn_param,
		date_modified = NOW()
	WHERE
		username = username_param;
	
	SELECT administrator_account_id INTO userID
	FROM administrator_account
	WHERE username = username_param;
	
	UPDATE
		administrator_role
	SET
		security_role_id = securityid_param,
		date_modified = NOW()
	WHERE
		administrator_account_id = userID;
	
	SELECT username INTO updatedUser
	FROM administrator_account
	WHERE administrator_account_id = userID;
	
	RETURN updatedUser;
END; $$
LANGUAGE PLPGSQL;
