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

echo -e "${Y}CLI unit testing start${NC}";
echo -e "${P}Login and logout as Anonymous${NC}";
se2224 login > /dev/null 2>&1;
se2224 logout > /dev/null 2>&1;
echo -e "${G}Done${NC}";

echo -e "${P}Login and logout with credentials${NC}";
declare -a user=("George" "John" "Minos")
declare -a word=("Baris" "Chatzis" "Kountourakis")
for i in "${!user[@]}"; 
do
se2224 login --username ${user[i]} --password ${word[i]} > /dev/null 2>&1;
se2224 logout > /dev/null 2>&1;
spin
done
echo -e "\b${G}Done${NC}";

echo -e "${P}Login with admin credentials${NC}";
se2224 login --username Admin --password Admin123 > /dev/null 2>&1;
echo -e "\b${G}Done${NC}";

echo -e "${P}Healthcheck${NC}";
se2224 healthcheck > /dev/null 2>&1;
echo -e "${G}Done${NC}";

echo -e "${P}View a Questionnaire${NC}";
se2224 questionnaire --questionnaire_id QQ000 > /dev/null 2>&1;
se2224 questionnaire --questionnaire_id QQ001 > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}View a Question${NC}";
se2224 question --questionnaire_id QQ000 --question_id Q00 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ000 --question_id Q01 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ000 --question_id Q02 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ000 --question_id Q03 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q04 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q05 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q06 > /dev/null 2>&1;
spin
se2224 question --questionnaire_id QQ001 --question_id Q07 > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Upload a Questionnaire${NC}";
se2224 questionnaire_upd --source Questionnaire_gia_exetash.json > /dev/null 2>&1;
spin
se2224 questionnaire --questionnaire_id QQ100 > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Create a session to answer a questionnaire${NC}";
se2224 createsession --questionnaire_id QQ000 --session_id FGHJ > /dev/null 2>&1;
spin
se2224 createsession --questionnaire_id QQ001 --session_id KJUY > /dev/null 2>&1;
spin
se2224 createsession --questionnaire_id QQ100 --session_id ADMN > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

##################################################################
echo -e "${P}Answer the questions${NC}";
se2224 doanswer --questionnaire_id QQ000 --question_id Q00 --session_id FGHJ --option_id Q00A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q00 --session_id FGHJ --option_id Q00A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q00 --session_id FGHJ --option_id Q00A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ000 --question_id Q01 --session_id FGHJ --option_id Q01A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q01 --session_id FGHJ --option_id Q01A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q01 --session_id FGHJ --option_id Q01A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ000 --question_id Q02 --session_id FGHJ --option_id Q02A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q02 --session_id FGHJ --option_id Q02A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q02 --session_id FGHJ --option_id Q02A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ000 --question_id Q03 --session_id FGHJ --option_id Q03A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q03 --session_id FGHJ --option_id Q03A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ000 --question_id Q03 --session_id FGHJ --option_id Q03A3 > /dev/null 2>&1;
spin
###################################################################
se2224 doanswer --questionnaire_id QQ001 --question_id Q04 --session_id KJUY --option_id Q04A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q04 --session_id KJUY --option_id Q04A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q04 --session_id KJUY --option_id Q04A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ001 --question_id Q05 --session_id KJUY --option_id Q05A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q05 --session_id KJUY --option_id Q05A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q05 --session_id KJUY --option_id Q05A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ001 --question_id Q06 --session_id KJUY --option_id Q06A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q06 --session_id KJUY --option_id Q06A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q06 --session_id KJUY --option_id Q06A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ001 --question_id Q07 --session_id KJUY --option_id Q07A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q07 --session_id KJUY --option_id Q07A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ001 --question_id Q07 --session_id KJUY --option_id Q07A3 > /dev/null 2>&1;
spin
#################################################################
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ADMN --option_id P00A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ADMN --option_id P00A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ADMN --option_id P00A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ADMN --option_id P00A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P00 --session_id ADMN --option_id P00A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ADMN --option_id P01A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ADMN --option_id P01A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ADMN --option_id P01A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ADMN --option_id P01A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P01 --session_id ADMN --option_id P01A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P02 --session_id ADMN --option_id P02A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P02 --session_id ADMN --option_id P02A2 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ADMN --option_id P03A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ADMN --option_id P03A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ADMN --option_id P03A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ADMN --option_id P03A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P03 --session_id ADMN --option_id P03A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ADMN --option_id P04A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ADMN --option_id P04A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ADMN --option_id P04A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ADMN --option_id P04A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P04 --session_id ADMN --option_id P04A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ADMN --option_id P05A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ADMN --option_id P05A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ADMN --option_id P05A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ADMN --option_id P05A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P05 --session_id ADMN --option_id P05A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ADMN --option_id P06A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ADMN --option_id P06A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ADMN --option_id P06A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ADMN --option_id P06A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P06 --session_id ADMN --option_id P06A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P07 --session_id ADMN --option_id P07A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P07 --session_id ADMN --option_id P07A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P07 --session_id ADMN --option_id P07A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P08 --session_id ADMN --option_id P08A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P08 --session_id ADMN --option_id P08A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P08 --session_id ADMN --option_id P08A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P09 --session_id ADMN --option_id P09A3 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P09 --session_id ADMN --option_id P09A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P09 --session_id ADMN --option_id P09A5 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P10 --session_id ADMN --option_id P10A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P10 --session_id ADMN --option_id P10A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P10 --session_id ADMN --option_id P10A3 > /dev/null 2>&1;
spin

se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A1 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A2 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A3 > /dev/null 2>&1;
spinse2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A4 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A5 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A6 > /dev/null 2>&1;
spin
se2224 doanswer --questionnaire_id QQ100 --question_id P11 --session_id ADMN --option_id P11A7 > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";
#################################################################


echo -e "${P}Get a summary of the answers of a session${NC}";
se2224 getsessionanswers --questionnaire_id QQ000 --session_id FGHJ > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ001 --session_id KJUY > /dev/null 2>&1;
spin
se2224 getsessionanswers --questionnaire_id QQ100 --session_id ADMN > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Get all the answers to a question${NC}";
se2224 getquestionanswers --questionnaire_id QQ000 --question_id Q00 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ000 --question_id Q01 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ000 --question_id Q02 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ000 --question_id Q03 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ001 --question_id Q04 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ001 --question_id Q05 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ001 --question_id Q06 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ001 --question_id Q07 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P00 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P01 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P02 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P03 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P04 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P05 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P06 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P07 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P08 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P09 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P10 > /dev/null 2>&1;
spin
se2224 getquestionanswers --questionnaire_id QQ100 --question_id P11 > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Reset a questionnaire${NC}";
se2224 resetq --questionnaire_id QQ000 > /dev/null 2>&1;
spin
se2224 resetq --questionnaire_id QQ001 > /dev/null 2>&1;
spin
se2224 resetq --questionnaire_id QQ100 > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Admin: Create new users${NC}";
se2224 admin --usermod --username Constantine --password Safos --email test1@identified.com > /dev/null 2>&1;
spin
se2224 admin --usermod --username Demetres --password Kogios --email test2@identified.com > /dev/null 2>&1;
spin
se2224 admin --usermod --username Peter --password Raptopoulos --email test3@identified.com > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";

echo -e "${P}Check info of new users${NC}";
se2224 admin --users Constantine > /dev/null 2>&1;
spin
se2224 admin --users Demetres > /dev/null 2>&1;
spin
se2224 admin --users Peter > /dev/null 2>&1;
spin
echo -e "\b${G}Done${NC}";
endspin
echo -e "${C}End of test reached${NC}";
