#!/bin/bash

Y='\033[1;33m';
G='\033[1;32m';
P='\033[0;35m';
C='\033[0;36m';
NC='\033[0m'; #no colour

sp="/-\|"
sc=0
spin() {
printf "\b${sp:sc++:1}"
((sc==${#sp})) && sc=0
}

endspin() {
printf "\b\r%s\n" "$@"
}

echo -e "${Y}CLI functional testing start${NC}";
echo -e "${P}Admin logs in, creates new users, uploads questionnaire${NC}";
se2224 login --username Admin --password Admin123 > /dev/null 2>&1;
spin
se2224 healthcheck > /dev/null 2>&1;
spin
se2224 questionnaire_upd --source Questionnaire_gia_exetash.json > /dev/null 2>&1;
spin
se2224 admin --usermod --username Constantine --password Safos --email test1@identified.com > /dev/null 2>&1;
spin
se2224 admin --usermod --username Demetres --password Kogios --email test2@identified.com > /dev/null 2>&1;
spin
se2224 admin --usermod --username Peter --password Raptopoulos --email test3@identified.com > /dev/null 2>&1;
spin
se2224 admin --users Constantine > /dev/null 2>&1;
spin
se2224 admin --users Demetres > /dev/null 2>&1;
spin
se2224 admin --users Peter > /dev/null 2>&1;
spin
se2224 logout > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Anonymous user${NC}";
se2224 login > /dev/null 2>&1;
spin
se2224 healthcheck > /dev/null 2>&1;
spin
############################################################
se2224 questionnaire --questionnaire_id QQ000 > /dev/null 2>&1;
spin
se2224 createsession --questionnaire_id QQ000 --session_id ANON > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ000 --question_id Q00 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q00 --session_id ANON --option_id Q00A1 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ000 --question_id Q01 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q01 --session_id ANON --option_id Q01A1 > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ000 --session_id ANON
echo ""
################################################################
se2224 questionnaire --questionnaire_id QQ001 > /dev/null 2>&1;
spin
se2224 createsession --questionnaire_id QQ001 --session_id ANO1 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q04 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q04 --session_id ANO1 --option_id Q04A1 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q05 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q05 --session_id ANO1 --option_id Q04A2 > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ001 --session_id ANO1 
echo ""
################################################################
se2224 createsession --questionnaire_id QQ100 --session_id ANO2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P00 > /dev/null 2>&1;
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ANO2 --option_id P00A4 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P01 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ANO2 --option_id P01A5 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P02 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P02 --session_id ANO2 --option_id P02A1 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P03 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ANO2 --option_id P03A4 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P04 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ANO2 --option_id P04A3 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P05 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ANO2 --option_id P05A4 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P06 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ANO2 --option_id P06A2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P07 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P07 --session_id ANO2 --option_id P07A1 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P08 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P08 --session_id ANO2 --option_id P08A2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P09 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P09 --session_id ANO2 --option_id P09A4 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P10 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P10 --session_id ANO2 --option_id P10A2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ100 --question_id P11 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ANO2 --option_id P11A1 > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ100 --session_id ANO2 
echo ""
se2224 logout > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Newly created user${NC}";
spin
se2224 login --username Constantine --password Safos > /dev/null 2>&1;
spin
se2224 healthcheck > /dev/null 2>&1;
spin
############################################################
se2224 questionnaire --questionnaire_id QQ000 > /dev/null 2>&1;
spin
se2224 createsession --questionnaire_id QQ000 --session_id KOST > /dev/null 2>&1;
se2224 question --questionnaire_id QQ000 --question_id Q00 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q00 --session_id KOST --option_id Q00A2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ000 --question_id Q02 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q02 --session_id KOST --option_id Q02A3 > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ000 --session_id KOST 
echo ""
################################################################
se2224 questionnaire --questionnaire_id QQ001 > /dev/null 2>&1;
spin
se2224 createsession --questionnaire_id QQ001 --session_id SAF2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q04 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q04 --session_id SAF2 --option_id Q04A2 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q06 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q06 --session_id SAF2 --option_id Q06A3 > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ001 --session_id SAF2 
echo ""
se2224 logout > /dev/null 2>&1;
echo -e "\b${G}Done${NC}";

echo -e "${P}Admin checks results${NC}";
se2224 login --username Admin --password Admin123 > /dev/null 2>&1;
spin
se2224 healthcheck > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ000 --question_id Q00 
se2224 getquestionanswers --questionnaire_id QQ001 --question_id Q04
se2224 logout > /dev/null 2>&1;
echo -e "${G}Done${NC}";

echo -e "${C}End of test reached${NC}";
endspin
