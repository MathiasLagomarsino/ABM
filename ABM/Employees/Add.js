$(document).ready(() =>{

  $(".val").click(() =>{


    var doAction = $("#doAction").val();
    var EmployeeID = $("#EmployeeID").val();
    
    var EmployeeName= $('#EmployeeName').val();
    EmployeeName = $.trim(EmployeeName);

    var EmployeeLastName= $('#EmployeeLastName').val();
    EmployeeLastName = $.trim(EmployeeLastName);

    var EmployeeDNI = $('#EmployeeDNI').val();

    var EmployeeBirthDate = $("#EmployeeBirthDate").val();

    var EmployeeeMail = $('#EmployeeeMail').val();
    var EmployeeeMail= $.trim(EmployeeeMail);

    var EmployeeAddress = $('#EmployeeAddress').val();
    var EmployeeAddress= $.trim(EmployeeAddress);

    var EmployeeRoleID = $('#EmployeeRoleID').val();
    var EmployeeSalary = $('#EmployeeSalary').val()

    var EmployeeDelete = 0;

    if($("#EmployeeDelete").is(':checked') ){
      EmployeeDelete = 1;
    }
    else
    EmployeeDelete = 0;


    var EmployeePhonestr ="";
    $("[name='phone']").each(function(){

      EmployeePhonestr = EmployeePhonestr + $(this).val() + ",";

    });

    EmployeePhonestr = EmployeePhonestr.substring(0,EmployeePhonestr.length-1)


    console.log("ID:"+ EmployeeID +", Nombre="+EmployeeName+", Apellido="+EmployeeLastName+", Telefono/s="+EmployeePhonestr+", Fecha de nacimiento="+EmployeeBirthDate+", DNI="+EmployeeDNI+", Mail="+EmployeeeMail+", Direccion="+EmployeeAddress+", Cargo="+EmployeeRoleID+ ", Salario="+EmployeeSalary+", Eliminado="+EmployeeDelete);


    doAjaxRequest(doAction,
      EmployeeName,
      EmployeeLastName,
      EmployeeDNI,
      EmployeeRoleID,
      EmployeeSalary,
      EmployeeAddress,
      EmployeeBirthDate,
      EmployeeeMail,
      EmployeePhonestr,
      EmployeeID,
      EmployeeDelete)

      $("form").submit((e) => {
        e.preventDefault();
      });

    })
  });


  var WS_URL = 'WS.asp';
  var SEPARATOR = '- - - - - - - - - - - - - - - - - - - - - -'


  function doAjaxRequest( doAction,
    EmployeeName,
    EmployeeLastName,
    EmployeeDNI,
    EmployeeRoleID,
    EmployeeSalary,
    EmployeeAddress,
    EmployeeBirthDate,
    EmployeeeMail,
    EmployeePhonestr,
    EmployeeID,
    EmployeeDelete){


      console.log(SEPARATOR);
      console.log("function doAjaxRequest( doAction,EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhonestr,EmployeeID,EmployeeDelete)");

      console.log("ID:"+ EmployeeID +
      ", Nombre=" + EmployeeName +
      ", Apellido=" + EmployeeLastName +
      ", Telefono/s=" + EmployeePhonestr +
      ", Fecha de nacimiento=" + EmployeeBirthDate +
      ", DNI=" + EmployeeDNI +
      ", Mail=" + EmployeeeMail +
      ", Direccion=" + EmployeeAddress +
      ", Cargo=" + EmployeeRoleID +
      ", Salario="+EmployeeSalary+
      ", Eliminado=" + EmployeeDelete );



      $.ajax({
        url: "ws/ws.asp",
        async: true,
        type: "POST",
        dataType: "json",
        data: {
          doAction : doAction,
          EmployeeName : EmployeeName,
          EmployeeLastName : EmployeeLastName,
          EmployeeDNI : EmployeeDNI,
          EmployeeRoleID : EmployeeRoleID,
          EmployeeSalary : EmployeeSalary,
          EmployeeAddress : EmployeeAddress,
          EmployeeBirthDate : EmployeeBirthDate,
          EmployeeeMail : EmployeeeMail,
          EmployeePhonestr : EmployeePhonestr,
          EmployeeID : EmployeeID,
          EmployeeDelete : EmployeeDelete
        }
      })
      .done(function (data) {
        console.log(SEPARATOR);
        console.log("Gane!");
        console.log(data);
        console.log(SEPARATOR);
        if(data.success > 0)

        window.location.href = "details.asp?result="+ data.success +"&EmployeeID="+ EmployeeID;
        else
        {
          /*var errorDesc = data.errorDesc.trim();
          var errDiv = $("<div class='msgProccess'><h1 class='error' id='error'><i class='fa fa-times'>"+errorDesc);
          var h1 = $("<h1>")
          var i = $("<i>");



          errDiv.val(errorDesc)
          $(".topnav").append(errDiv)
          */

        }
      })
      .fail(function (data) {
        console.log(SEPARATOR);
        console.log("Todo mal!");
        console.log(data);
        console.log(SEPARATOR);

      });
    }
