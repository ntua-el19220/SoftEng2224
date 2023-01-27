function showQuestionnaire(row) {
    $('#questionnaireHeader').html(`Info Regarding Questionnaire "${row.getAttribute("data-questionnaireTitle")}"`);   
    $('#questionnaireHeader').show();
    $.ajax({
        url: `https://localhost:9103/intelliq_api/questionnaire/"${row.getAttribute("data-questionnaireID")}"`,
        headers:{'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')},
        type: 'GET',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        cache: false,
        async: false,
        success: function(data) {
            $('#questions-table').html("");   // Clear the table
            for (var i=0; i<data.questions.length; i++) {
                $('#questions-table').append("<tr>"+
                "<td>"+data.questions[i].qID+"</td>"+    
                "<td>"+data.questions[i].qtext+"</td>"+
                "<td>"+data.questions[i].required+"</td>"+
                "<td>"+data.questions[i].type+"</td>"+
                '<td><a type="button" onclick="showQuestionInfo(this)" \
                data-questionnaireID='+ `${row.getAttribute("data-questionnaireID")}` +' \
                data-qID='+ data.questions[i].qID +' \
                data-qtext='+ '"' + data.questions[i].qtext + '"' +'> \
                <i class = "fa fa-eye"></i></a></td>'+
                "</tr>");
            }
            $('#questionsCard').show();
        },
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

async function showQuestionInfo(row) {
    // Set new default font family and font color to mimic Bootstrap's default styling
    Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
    Chart.defaults.global.defaultFontColor = '#292b2c';

    let {options, answers} = await getOptions_Answers(row.getAttribute("data-questionnaireID"), row.getAttribute("data-qID"));
    answers = answers.answers;
    async function getOptions_Answers(questionnaireID, qID) {
        const data = await $.ajax({
            url: `https://localhost:9103/intelliq_api/question/"${questionnaireID}"/"${qID}"`,
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
        return {options:data.options, answers:await getquestionanswers(questionnaireID, qID)};
    }

    async function getquestionanswers(questionnaireID, qID) {
        return $.ajax({
            url: `https://localhost:9103/intelliq_api/getquestionanswers/"${questionnaireID}"/"${qID}"`,
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
    options = options.sort((a, b) => a.optID.localeCompare(b.optID));
    answers = answers.sort((a, b) => a.ans.localeCompare(b.ans));
    const labels = options.map(item => item.opttxt);
    const counts = {};
    for (const json of answers) {
        counts[json.ans] = counts[json.ans] ? counts[json.ans] + 1 : 1;
    }

    // Pie Chart Example
    var ctx = document.getElementById("myPieChart");
    var myPieChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: labels,
        datasets: [{
        data: Object.values(counts),
        //backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745'],
        }],
    },
    });
    $('#graphs').show();
}