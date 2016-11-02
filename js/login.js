var Login = {
    basic: function() {
        var a = $("#login-form").serializeArray();
        $.ajax({
            url: "../php/login.php",
            type: "POST",
            data: a,
            dataType: "html",
            beforeSend: function() {},
            complete: function() {},
            error: function(a, b, c) {
                console.log(c);
            },
            success: function(a, b, c) {
                var d = a.trim();
                if ("student" == d) {
                    window.location="home.html";
                } else if  ("classincharge" == d) {
                    window.location="homeclassincharge.html";
                } else {
                    window.location="index.html";
                }
            }
        });
    }
};