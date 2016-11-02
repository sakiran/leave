$(document).ready(function() {

    
    $.ajax({
        url: "../php/userinfo.php",
        type: "POST",

        beforeSend: function() {},
        complete: function() {},
        error: function(a, b, c) {
            console.log(c);
        },
        success: function(a, b, d) {
            var e = JSON.parse(a);
            document.getElementById("username").innerHTML = e.username;
            document.getElementById("department").innerHTML = e.department;
            document.getElementById("departmenthidden").value = e.department;
            document.getElementById("dateofjoining").innerHTML = e.dateofjoining;
            document.getElementById("gender").innerHTML = e.gender;
            document.getElementById("homeaddress").innerHTML = e.homeaddress;
            document.getElementById("email").innerHTML = e.email;
            document.getElementById("phonenumber").innerHTML = e.phonenumber;




        }

    });
});