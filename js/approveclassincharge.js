$(document)
    .ready(function () {



        $.ajax({
            url: "../php/userinfo.php",
            type: "POST",

            beforeSend: function () {},
            complete: function () {},
            error: function (a, b, c) {
                console.log(c);
            },
            success: function (a, b, d) {
                var e = JSON.parse(a);
                document.getElementById("username")
                    .innerHTML = e.username;




            }

        });




        $.ajax({
            url: "../php/approveclassincharge.php",
            type: "POST",

            beforeSend: function () {},
            complete: function () {},
            error: function (a, b, c) {
                console.log(c);
            },
            success: function (a, b, d) {
                var json = jQuery.parseJSON(a);
                var serialnumber;
                serialnumber = 0;


                for (var i in json) {


                    serialnumber = serialnumber + 1;

                    serialno = json[i].serialno;
                    console.log(serialno);


                    $("#approvetable > tbody")
                        .append(" <tr>" + "<td>" + serialnumber + "</td><td>" +
                            json[i].username + "</td><td>" + json[i].fromdate +
                            "</td><td>" + json[i].todate + "</td><td>" +
                            json[i].reason + "</td> <td> " +


                            " <span ><a href=\"../php/updatestatus.php?status=Approved&serialno=" +serialno+
                            
                            "\" " +
                            "data-original-title=\"Edit this user\" data-toggle=\"tooltip\"  " +
                            "type=\"button\" class=\"btn btn-sm btn-primary\"><i class=\"glyphicon glyphicon-ok\"></i></a> " +
                            "<a href=\"../php/updatestatus.php?status=Rejected&serialno=" +serialno+
                           
                            "\" " +
                            "data-original-title=\"Remove this user\" data-toggle=\"tooltip\" type=\"button\" " +
                            "class=\"btn btn-sm btn-danger\"><i class=\"glyphicon glyphicon-remove\"></i></a> " +
                            "  </span></td>" + "</tr>");




                }




            }

        });




    });
