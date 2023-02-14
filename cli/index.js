#! /usr/bin/env -S node --no-warnings
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"

const commander = require("commander");
const axios = require ('axios');
const program = new commander.Command();
const fs = require('fs');
var querystring = require('querystring');

const login_call = require('./commands/login.js');
const questionnaire_upd_call = require('./adminCommands/questionnaire_upd.js');
const resetq_call = require('./adminCommands/resetq.js');
const questionnaire_call = require('./commands/questionnaire.js');
const question_call = require('./commands/question.js');
const doanswer_call = require('./commands/doanswer.js');
const getsessionanswers_call = require('./commands/getsessionanswers.js');
const getquestionanswers_call = require('./commands/getquestionanswers.js');
const admin_usermod_call = require('./adminCommands/adminusermod.js');
const admin_users_call = require('./adminCommands/adminusers.js');
const session_call = require('./commands/createsession.js');

program
    .version('1.0.0')
    .description('Command Line Interface Software Engineering NTUA 2022-23');

//CLI operation options:

program
    .command('login')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Login')
    .requiredOption('--username <username>',  'Your username', 'AnonymousUser')
    .option('--password <password>',  'Your password', '')
    .action((options)=> {
    login_call(options.username, options.password);
});


program
    .command('logout')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Ends the current session')
    .action(function(){
      let url='https://localhost:9103/intelliq_api/logout';
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
            if(err) {console.log(err);}
            const token = contents;
            axios.post(url, token, {
              headers: { 'X-OBSERVATORY-AUTH': token}}).then(resp=>{
              console.log(resp.data);
            })
      })
    });


program
    .command('healthcheck')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Confirms connection to database')
    .action(function(){
      let url='https://localhost:9103/intelliq_api/admin/healthcheck';
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
            if(err) {console.log(err);}
            const token = contents;
            axios.get(url, {
              headers: { 'X-OBSERVATORY-AUTH': token}}).then(resp=>{
              console.log(resp.data);
            })
        })
    });


program
    .command('resetall')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Resets all questionnaires, answers and users')
    .action(function(){
        let url='https://localhost:9103/intelliq_api/admin/resetall';
        fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
            if(err) {console.log(err);}
            const token = contents;
            axios.post(url, token, {
              headers: { 'X-OBSERVATORY-AUTH': token}}).then(resp=>{
              console.log(resp.data);
            })
        })
    });


program
    .command('questionnaire_upd')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Upload a json file with a questionnaire')
    .requiredOption('--source <source>',  'The name of the json file that contains the questionnaire')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        questionnaire_upd_call(options.source, token);
      })
    });

program
    .command('resetq')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Reset target questionnaire')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire to be reseted')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        resetq_call(options.questionnaire_id, token);
      })
    });

program
    .command('questionnaire')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Returns info and questions of target questionnaire')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire')
    .option('--format <format>',  'Choose a format (json or csv)', 'json')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        questionnaire_call(options.questionnaire_id, options.format, token);
      })
    });

program
    .command('question')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Returns a question and its answers')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire')
    .requiredOption('--question_id <question_id>',  'The id of the question')
    .option('--format <format>',  'Choose a format (json or csv)', 'json')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        question_call(options.questionnaire_id, options.question_id, options.format, token);
      })
    });
    
program
    .command('createsession')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Gives you a session key to answer questions')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire')
    .requiredOption('--session_id <session_id>', '4 capital letters, the id of the created session')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        session_call(options.questionnaire_id, options.session_id, token);
      })
    });

program
    .command('doanswer')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Answer a question')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire')
    .requiredOption('--question_id <question_id>',  'The id of the question')
    .requiredOption('--session_id <session_id>',  'The id of your session')
    .requiredOption('--option_id <option_id>',  'The id of the chosen option (answer)')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        doanswer_call(options.questionnaire_id, options.question_id, options.session_id, options.option_id, token);
      })
    });

program
    .command('getsessionanswers')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'See all answers given in this session')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire')
    .requiredOption('--session_id <session_id>',  'The id of your session')
    .option('--format <format>',  'Choose a format (json or csv)', 'json')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        getsessionanswers_call(options.questionnaire_id, options.session_id, options.format, token);
      })
    });

program
    .command('getquestionanswers')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'See all answers to this question')
    .requiredOption('--questionnaire_id <questionnaire_id>',  'The id of the questionnaire')
    .requiredOption('--question_id <question_id>',  'The id of the question')
    .option('--format <format>',  'Choose a format (json or csv)', 'json')
    .action((options)=> {
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        getquestionanswers_call(options.questionnaire_id, options.question_id, options.format, token);
      })
    });


// CLI options for admin users
program
    .command('admin')
    .showHelpAfterError('add --help for additional information')
    .helpOption('-h, --help', 'Display help for command')
    .addHelpText('after', 'Options for admin users')
    .option('--usermod',  'Register new user. Enter arguments: --username <username> --password <password> --email <email>')
    .option('--username <username>',  'Your username')
    .option('--password <password>',  'Your password')
    .option('--email <email>', 'Your email')
    .option('--users <username>',  'Show the status of user <username>. Enter arguments: --username <username> --format <format>')
    .option('--format <format>',  'Choose a format (json or csv)', 'json')
    .action((options)=>{
      fs.readFile('Intelliq_token.txt', {encoding: 'utf8'}, function(err, contents){
        if(err) {console.log(err);}
        const token = contents;
        if ((options.usermod) && (options.users != undefined))
            console.error('Usermod mode active and argument --users was given')
        else if ((options.usermod) && ((options.username == undefined) || (options.password == undefined) || (options.email == undefined)))
            console.error('Argument \'--usermod\' must be followed by \'--username <username> --password <password> --email <email>\'');
        else if (options.usermod)
            admin_usermod_call(options.username, options.password, options.email, token);
        else if (options.users != undefined)
            admin_users_call(options.users, options.format, token);
      })
    });

program.parse(process.argv);
