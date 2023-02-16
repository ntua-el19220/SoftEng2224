#!/bin/bash

Y='\033[1;33m';
G='\033[0;32m';
P='\033[0;35m';
C='\033[0;36m';
NC='\033[0m'; #no colour

echo -e "${Y}CLI test start${NC}";
echo -e "${P}Login as Anonymous${NC}";
se2224 login

echo -e "${P}Logout${NC}";
se2224 logout

echo -e "${P}Login with admin credentials${NC}";
se2224 login --username Admin --password Admin123

echo -e "${P}Healthcheck${NC}";
se2224 healthcheck

echo -e "${P}View a Questionnaire${NC}";
se2224 questionnaire --questionnaire_id QQ000

echo -e "${P}View a Question${NC}";
se2224 question --questionnaire_id QQ000 --question_id Q00

echo -e "${P}Upload a Questionnaire${NC}";
se2224 questionnaire_upd --source Questionnaire_gia_exetash.json
se2224 questionnaire --questionnaire_id QQ100

echo -e "${P}Create a session to answer a questionnaire${NC}";
se2224 createsession --questionnaire_id QQ100 --session_id ADMN;

echo -e "${P}Answer the questions${NC}";
se2224 question --questionnaire_id QQ100 --question_id P00
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ADMN --option_id P00A4

se2224 question --questionnaire_id QQ100 --question_id P01
se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ADMN --option_id P01A5

se2224 question --questionnaire_id QQ100 --question_id P02
se2224 doanswer --questionnaire_id QQ100 --question_id P02 --session_id ADMN --option_id P02A1

se2224 question --questionnaire_id QQ100 --question_id P03
se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ADMN --option_id P03A4

se2224 question --questionnaire_id QQ100 --question_id P04
se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ADMN --option_id P04A3

se2224 question --questionnaire_id QQ100 --question_id P05
se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ADMN --option_id P05A4

se2224 question --questionnaire_id QQ100 --question_id P06
se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ADMN --option_id P06A2

se2224 question --questionnaire_id QQ100 --question_id P07
se2224 doanswer --questionnaire_id QQ100 --question_id P07 --session_id ADMN --option_id P07A1

se2224 question --questionnaire_id QQ100 --question_id P08
se2224 doanswer --questionnaire_id QQ100 --question_id P08 --session_id ADMN --option_id P08A2

se2224 question --questionnaire_id QQ100 --question_id P09
se2224 doanswer --questionnaire_id QQ100 --question_id P09 --session_id ADMN --option_id P09A4

se2224 question --questionnaire_id QQ100 --question_id P10
se2224 doanswer --questionnaire_id QQ100 --question_id P10 --session_id ADMN --option_id P10A2

se2224 question --questionnaire_id QQ100 --question_id P11
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A1

echo -e "${P}Get a summary of the answers of a session${NC}";
se2224 getsessionanswers --questionnaire_id QQ100 --session_id ADMN

echo -e "${P}Get all the answers to a question${NC}";
se2224 getquestionanswers --questionnaire_id QQ000 --question_id Q00
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P09

echo -e "${P}Reset a questionnaire${NC}";
se2224 resetq --questionnaire_id QQ100
echo -e "${P}Now getquestionanswers should return: Request failed with status code 402${NC}";
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P09

echo -e "${P}Reset everything${NC}";
se2224 resetall

echo -e "${P}Admin: Create a new user Constantine${NC}";
se2224 admin --usermod --username Constantine --password Safos --email test1@identified.com

echo -e "${P}Check info of new user${NC}";
se2224 admin --users Constantine

echo -e "${P}Logout${NC}";
se2224 logout

echo -e "${C}End of test reached${NC}";
