$('#login-submit-btn').on('click', function() {
    loginApiCall();
}); 

function loginApiCall() {
    var checkbox = document.getElementById("inputAnonymous");
    if (checkbox.checked) {
        var username = "AnonymousUser";
        var password = "";
    } else {
        var username = document.getElementById("inputUsername").value;
        var password = document.getElementById("inputPassword").value;
    }
    $.ajax({
        url: `https://localhost:9103/intelliq_api/login`,
        type: 'POST',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: 'json',
        data : {"username":JSON.stringify(username), "password":JSON.stringify(password)},
        cache: false,
        async: false,
        success: function(data) {onSuccessLogin(data, JSON.stringify(username))},
        error: function(){
            Swal.fire({
                icon: 'error',
                title: "Login Failed!",
                text: "Try Again"
              })
        }
    });
}

// The cache property is set to false, which tells jQuery not to cache the response. 
// The async property is set to false, which tells jQuery to make the request synchronously.

function onSuccessLogin(data, username) {    
    sessionStorage.setItem('token', data.token);
    sessionStorage.setItem('username', username);
    Swal.fire({
        icon: 'success',
        title: "Login Successful!"
      })
    setTimeout(function(){
        window.location.href = '/';
    }, 2000);
    // setTimeout(function(){
    //     fetch('https://localhost
        //:8000', {
    //         method: 'GET',
    //         headers: {
    //             'X-OBSERVATORY-AUTH': sessionStorage.getItem('token')
    //         },
    //         credentials:'include'
    //     })
    //     .then(response => {
    //         if (response.ok) {
    //           return response.text();
    //         }
    //         throw new Error('Request failed');
    //       })
    //       .then(html => {
    //         // document.open();
    //         // document.write(html);
    //         // document.close();
    //         // let parser = new DOMParser();
    //         // let doc = parser.parseFromString(html, "text/html");
    //         // let body = doc.querySelector("body");
    //         // let bodyHTML = body.innerHTML;
    //         // document.body.innerHTML = bodyHTML;
    //       })
    //       .catch(error => {
    //         console.log(error);
    //       });
    //     //window.location.href = '/';
    // }, 2000);
}