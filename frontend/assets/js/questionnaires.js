$('#logout-btn').on('click', function() {
    $.ajax({
        url: `https://localhost:9103/intelliq_api/logout`,
        type: 'POST',
        headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
        cache: false,
        async: false,
        success: function(){
            sessionStorage.removeItem('token');
            Swal.fire({
                icon: 'success',
                title: "Logout Successful!",
                text: "Redirecting to Login Page"
              })
            setTimeout(function(){
                window.location.href = '/login';
            }, 2000);
        },
        error: function(){
            Swal.fire({
                icon: 'error',
                title: "Logout Failed!",
                text: "Try Again"
              })
        }
    });
}); 

$(document).ready(function(){

    $('#file-upload-form').submit(function(e) {
        e.preventDefault();

        var formData = new FormData(this);

        $.ajax({
            url: `https://localhost:9103/intelliq_api/admin/questionnaire_upd`,
            type: 'POST',
            headers:{
                'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')
            },
            contentType: false,
            processData: false,  
            data: formData,
            success: function(){
                Swal.fire({
                    icon: 'success',
                    title: "Questionnaire Created!"
                  })
            },
            error: function(){
                Swal.fire({
                    icon: 'error',
                    title: "Upload Failed!",
                    text: "Try Again"
                  })
            }
        });
    });

    if (location.pathname == '/') {
        $('#username').html(`${sessionStorage.getItem('username')}`);
        questionnairesApiCall();
    }
    
}); 

function questionnairesApiCall() {
    $.ajax({
        url: `https://localhost:9103/intelliq_api/getquestionnaires`,
        headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
        type: 'GET',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        cache: false,
        async: false,
        success: onSuccessQuestionnaires,
        error: function(jqXHR, textStatus, errorThrown){
            console.log(errorThrown, textStatus);
            if (errorThrown == 'Not authorized') { 
                Swal.fire({
                    icon: 'error',
                    title: "Login Is Needed!",
                    text: "Insert your credentials and try again"
                });
                setTimeout(function(){
                    window.location.href = '/login';
                }, 2000);
            } else alert("Error occured: " + textStatus + " - " + errorThrown);
        }
    });
}

// The cache property is set to false, which tells jQuery not to cache the response. 
// The async property is set to false, which tells jQuery to make the request synchronously.

var myLineChart=null;

async function onSuccessQuestionnaires(data) {    
    $('#questionnaires-table').html("");   // Clear the table
    // if admin is using the app display the showQuestionnaire button
    if (sessionStorage.getItem('username') == '"Admin"') {
        for (var i=0; i<data.questionnaires.length; i++) {
            $('#questionnaires-table').append("<tr>"+
            "<td>"+data.questionnaires[i].questionnaireID+"</td>"+    
            "<td>"+data.questionnaires[i].questionnaireTitle+"</td>"+
            "<td>"+data.questionnaires[i].dateUpdated+"</td>"+
            '<td><a type="button" onclick="showQuestionnaire(this)" \
            data-questionnaireID='+ data.questionnaires[i].questionnaireID +' \
            data-questionnaireTitle='+ '"' + data.questionnaires[i].questionnaireTitle + '"' +'> \
            <i class = "fa fa-eye"></i></a></td>'+
            '<td><a type="button" onclick="ansQuestionnaire(this)" \
            data-questionnaireID='+ data.questionnaires[i].questionnaireID +' \
            data-questionnaireTitle='+ '"' + data.questionnaires[i].questionnaireTitle + '"' +'> \
            <i class="fa fa-edit"></i></a></td>'+
            "</tr>");
        }

        const questionnaires = data.questionnaires;
        const labels = [];
        const IDs = [];
        const counts = [];
        for (const questionnaire of questionnaires) {
            labels.push(questionnaire.questionnaireTitle);
            IDs.push(questionnaire.questionnaireID);
            counts.push(0);
        }

        let {sessions} = await getSessions();

        async function getSessions() {
            return $.ajax({
                url: `https://localhost:9103/intelliq_api/getsessions/`,
                headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
                type: 'GET',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                cache: false,
                error: function(jqXHR, textStatus, errorThrown){
                    console.log(errorThrown, textStatus);
                    if (errorThrown == 'Not authorized') { 
                        Swal.fire({
                            icon: 'error',
                            title: "Login Is Needed!",
                            text: "Insert your credentials and try again"
                        });
                        setTimeout(function(){
                            window.location.href = '/login';
                        }, 2000);
                    } else alert("Error occured: " + textStatus + " - " + errorThrown);
                }
            });
        }
        
        function find_index(key, array){
            for (let i=0; i < array.length; i++) {
                if (array[i] === key) {
                    return i;
                }
            }
        }

        for (const session of sessions) {
            counts[find_index(session.questionnaireID, IDs)]++;
        }
        
        var ctx = document.getElementById("myBarChart");
        if(myLineChart!=null) myLineChart.destroy();
        myLineChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
            label: "Answers",
            backgroundColor: "rgba(2,117,216,1)",
            borderColor: "rgba(2,117,216,1)",
            data: counts,
            }],
        },
        options: {
            scales: {
            xAxes: [{
                time: {
                unit: 'Questionnaire'
                },
                gridLines: {
                display: false
                },
                ticks: {
                maxTicksLimit: 10
                }
            }],
            yAxes: [{
                ticks: {
                min: 0,
                max: 20,
                maxTicksLimit: 20
                },
                gridLines: {
                display: true
                }
            }],
            },
            legend: {
            display: false
            }
        }
        });

        $('#bar_chart').show();

    } else 
        for (var i=0; i<data.questionnaires.length; i++) {
            $('#questionnaires-table').append("<tr>"+
            "<td>"+data.questionnaires[i].questionnaireID+"</td>"+    
            "<td>"+data.questionnaires[i].questionnaireTitle+"</td>"+
            "<td>"+data.questionnaires[i].dateUpdated+"</td>"+
            '<td><a type="button" onclick="ansQuestionnaire(this)" \
            data-questionnaireID='+ data.questionnaires[i].questionnaireID +' \
            data-questionnaireTitle='+ '"' + data.questionnaires[i].questionnaireTitle + '"' +'> \
            <i class="fa fa-edit"></i></a></td>'+
            "</tr>");
        }

}

function ansQuestionnaire(row) {
    // row.getAttribute("data-questionnaireID");
    Swal.fire({
        title: "Proceed to answer the Questionnaire:\n" + '"' + `${row.getAttribute("data-questionnaireTitle")}` + '"',
        confirmButtonText: 'Yes',
        showCancelButton: true,
      }).then((result) => {
        if (result.isConfirmed) {
            ansQuestionnaireApiCall(row.getAttribute("data-questionnaireID"), row.getAttribute("data-questionnaireTitle"));
        } 
      })
}

// ansQuestionnaireApiCall:
// 1) call api to create session done
// 2) call api to fetch questions 
// 3) display each question and store answer

// 4) check when submission is possible and call api doanswer for all saved answers

// Notes:
// submitted only if required questions are answered

function ansQuestionnaireApiCall(questionnaireID, questionnaireTitle) {
    $.ajax({
        url: `https://localhost:9103/intelliq_api/istheresession/"${questionnaireID}"`,
        headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
        type: 'GET',
        cache: false,
        async: false,
        success: function(data) {
            onSuccessAnsQuestionnaire(questionnaireID, questionnaireTitle, data);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert("Error occured: " + textStatus + " - " + errorThrown);
        }
    });
}

function onSuccessAnsQuestionnaire(questionnaireID, questionnaireTitle, data) {    
    if (data.message == "Questionnaire already answered by the user") {
        Swal.fire({
            icon: 'error',
            title: "Questionnaire Already Answered!",
            text:  "Your answers are unique and cannot be undone"
          })
    } else {
        $.ajax({
            url: `https://localhost:9103/intelliq_api/questionnaire/"${questionnaireID}"`,
            headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
            type: 'GET',
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            cache: false,
            async: false,
            success: function(questionnaireInfo) {
                firstQuestionID = questionnaireInfo.questions[0].qID;
                let requiredQuestions = 0;
                for (i = 0; i < questionnaireInfo.questions.length; ++i)
                    if (questionnaireInfo.questions[i].required == 'TRUE')
                        requiredQuestions++;
                let answeredQuestions = 0;
                givenAnswers = []; // record the answers till submission
                recAnswerQuestion(data.session, questionnaireID, firstQuestionID, givenAnswers, answeredQuestions, requiredQuestions);
            },
            error: function(jqXHR, textStatus, errorThrown){
                alert("Error occured: " + textStatus + " - " + errorThrown);
            }
        });
    }
}

//{baseURL}/question/:questionnaireID/:questionID
async function recAnswerQuestion(session, questionnaireID, qID, givenAnswers, answeredQuestions, requiredQuestions) {
    $.ajax({
        url: `https://localhost:9103/intelliq_api/question/"${questionnaireID}"/"${qID}"`,
        headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
        type: 'GET',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        cache: false,
        async: false,
        success: async function getQuestionInfo(questionInfo) {
            let options = {};
            let nextQuestions = {};
            for(i = 0; i < questionInfo.options.length; ++i) {
                options[questionInfo.options[i].optID] = questionInfo.options[i].opttxt;
                nextQuestions[questionInfo.options[i].optID] = questionInfo.options[i].nextqID;
            }
            const inputOptions = new Promise((resolve) => {
                setTimeout(() => {
                resolve(options)
                }, 1000)
            })
            
            Swal.fire({
                title: `${questionInfo.qtext}`,
                input: 'radio',
                allowOutsideClick: false,
                inputOptions: inputOptions,
                inputValidator: (value) => {
                if (!value && questionInfo.required == 'TRUE') {
                    return 'You need to choose something!'
                }
                },
                showConfirmButton: true, confirmButtonText: 'Next',
                showCancelButton: true, cancelButtonText: 'Exit Questionnaire',
                showDenyButton: (answeredQuestions >= requiredQuestions), denyButtonText: `Submit Anwers (Current Excluded)`, denyButtonColor: '#a0f58c'
            }).then(result => {
                if (!result.isDismissed) {
                    if (result.value) givenAnswers.push({"questionnaireID": `${questionnaireID}`, "questionID": `${qID}`, "session": `${session}`, "optionID": `${result.value}`, "qtext": `${questionInfo.qtext}`, "opttxt": `${options[result.value]}`});
                    if (nextQuestions[result.value] == null || result.isDenied) {
                        const title = (result.isDenied ? 'Required questions answered' : 'All questions answered!');
                        Swal.fire({
                            title: title,
                            icon: 'success',
                            confirmButtonText: 'Submit Answers',
                            allowOutsideClick: false
                          }).then((result) => { // givenAnswers now hold the final data for submission
                            // create session
                            $.ajax({
                                url: `https://localhost:9103/intelliq_api/createsession/"${questionnaireID}"/"${session}"`,
                                headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
                                type: 'POST',
                                cache: false,
                                async: false,
                                success: function(data) {
                                    const sessionFinal = data.session; // session final 
                                    recDoAnswer(0, sessionFinal);
                                    // review of submission
                                    var review = givenAnswers.map(function(object) {
                                        return 'Q: ' + object.qtext + '\n' + 'A: ' + object.opttxt + '\n';
                                    }).join('\n');
                                      
                                    Swal.fire({
                                        title: 'Review of Submission',
                                        // text: review,
                                        html: '<pre>' + '\n\n' + review + '</pre>',
                                        icon: 'info'
                                    });
                                },
                                error: function(jqXHR, textStatus, errorThrown){
                                    alert("Error occured: " + textStatus + " - " + errorThrown);
                                }
                            });

                            function recDoAnswer(counter, session) {
                                if (counter == givenAnswers.length) return;
                                $.ajax({
                                    url: `https://localhost:9103/intelliq_api/doanswer/"${givenAnswers[counter].questionnaireID}"/"${givenAnswers[counter].questionID}"/${session}/"${givenAnswers[counter].optionID}"`,
                                    headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
                                    type: 'POST',
                                    cache: false,
                                    async: false,
                                    success: function(data) {
                                        recDoAnswer(counter+1, session);
                                    },
                                    error: function(jqXHR, textStatus, errorThrown){
                                        alert("Error occured: " + textStatus + " - " + errorThrown);
                                    }
                                });
                            }
                          })
                    } else {
                        // last question will not be submited if denyButton pressed
                        recAnswerQuestion(session, questionnaireID, nextQuestions[result.value], givenAnswers, answeredQuestions+1, requiredQuestions);
                    }    
                } else {
                    Swal.fire({
                        title: 'All progress regarding this questionnaire will be discarded!',
                        text: "Are you sure?",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: 'No, return to questionnaire.',
                        confirmButtonText: 'Yes, exit.',
                        allowOutsideClick: false
                      }).then((result) => {
                        if (result.isConfirmed) {
                           
                        } else {
                            getQuestionInfo(questionInfo);
                        }
                      })
                }
            });
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert("Error occured: " + textStatus + " - " + errorThrown);
        }
    });
}