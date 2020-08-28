$(document).ready(() =>{
  $("form").submit((e) => {
    valid=validar();

    if(! valid)
    e.preventDefault();


  });

  $(".phDiv,#dni,#EmployeeSalary").on('keydown',(e) => {
    var key   = e.keyCode ? e.keyCode : e.which;

    if (!( [8, 9, 13, 27, 46, 110, 190].indexOf(key) !== -1 ||
    (key == 65 && ( e.ctrlKey || e.metaKey  ) ) ||
    (key >= 35 && key <= 40) ||
    (key >= 48 && key <= 57 && !(e.shiftKey || e.altKey)) ||
    (key >= 96 && key <= 105)
  )) e.preventDefault();
});
$('.addph').on('click', function(){
  var phone = $(".tel:last").val();
  addPh();

});

$('.addphone').on('click', function(){
  var phone = $(".tel:last").val();
  addPhEdit();

});
$(".phDiv").on('click','.phdel',  function(){
  var id= $(this).attr("telid");
  delPh(id);
});
});

var counter=2;

function validar(valid){
  //name surname ^([A-Za-z]{1,15})\s*(([A-Za-z]{1,15}){0,2})?\s*$
  var name = $('#namEmp').val();
  var nameReg = new RegExp('^[a-zA-Z]+(([a-zA-Z ])?[a-zA-Z]*){1,3}$');

  var surname = $('#surEmp').val();
  var surReg = new RegExp('^[a-zA-Z]+(([a-zA-Z ])?[a-zA-Z]*){1,3}$');
  var surnametr = $.trim(surname);

  var dni = $('#DNI').val();
  

  //^[a-zA-Z0-9._%+-]{0-20}+@[a-zA-Z0-9.-]?\.[a-zA-Z]{2,4}$
  var email = $('#mail').val();
  var emReg = new RegExp('^[a-zA-Z0-9\/\.\_\-]{1,30}[@][a-z0-9\/]{1,20}((([.][a-z]{3}){1})|(([.][a-z]{3}){1})([.][a-z]{2}$){1})$');

  var emailtr = $.trim(email);

  var dir = $('#dir').val();
  var dirReg = new RegExp('^\s?([A-Za-z]{1,}([\.,]))*[A-Za-z 0-9]+\.?\s*$');
  var dirtr = $.trim(dir);

  var phone = $(".tel:last").val();

  var posval = $('#pos').val();

  var salary = $('#EmployeeSalary').val();
  var salReg = salary.search(/^\$?\d+(,\d{3})*(\.\d*)?$/) >= 0;

  var error= $("<h4>");

  var valid=true;

  if(! nameReg.test(name))
  {
    if($('.namDivErr').length == 0)
    shValMsg('.namDiv','* Nombre invalido o vacío');
    valid=false;
  }

  if(! surReg.test(surname))
  {
    if($(".surDivErr").length == 0)
    shValMsg('.surDiv','* Apellido invalido o vacío');
    valid=false;
  }

  if(! dni == '' )
  {
    if($(".dniDivErr").length == 0)
    shValMsg('.dniDiv','* DNI invalido o vacío');
    valid=false;
  }

  if(emReg.test(email))
  {
    if($(".mailDivErr").length == 0)
    shValMsg('.mailDiv','* Mail invalido o vacío');
    valid=false;
  }

  if(phone == '')
  {
    if($(".phDivErr").length == 0)
    shValMsg('.phDiv','* Teléfono invalido o vacío');
    valid=false;
  }

  if($("#pos").val() == 0)
  {
    if($('.posDivErr').length == 0 )
    shValMsg('.posDiv','* Elija un cargo para el empleado');
    valid=false;
  }


  if(! dirReg.test(dir))
  {
    if($(".dirDivErr").length == 0)
    shValMsg('.dirDiv','* Dirección invalida o vacía');
    valid=false;
  }
  return valid;
}





function shValMsg(sel,text){
  var id= sel.substring(1)+"Err";
  var msg = $('<h4>');

  msg.attr('class',id);
  msg.addClass("alerta");

  msg.text(text);
  $(sel).after(msg);
  setTimeout(function(){
    $(msg).remove();
  }, 2220);
}

function addPh(phone){

  var id ='ph'+counter;
  var ph ='del'+counter;
  var ph = $("#"+id+"").val();

  if($(".tel:last").val() == '')
  {
    if($(".errPhEmpty").length == 0)
    valph("PhEmpty",'* Rellene el campo')
    return;
  }
  if(counter > 5)
  return;

  var input = $("<input>");
  var phdel = $("<button id='" + ph + "' telid='0" + counter + "' >");
  phdel.html("<i class='fa fa-times loading' telid='0" + counter + "' >");
  var br = $("<br telid='0" + counter + "'><br telid='0" + counter + "'>");
  phdel.addClass('phdel');
  input.addClass('tel');
  input.attr({
    type:"text",
    placeholder:"Ingrese telefono",
    maxlength:15,
    id:""+id,
    name:"phone",
    telid:"0"+counter
  });
  if(!phone == '')
  input.val(phone);
  counter++;
  $("[telid]").prop('readonly', true);
  $("button[telid]:last").hide();
  $("button[telid]:last").css({"background-color": "#ffc1c1"});
  $('.phDiv').append(br,input,phdel);
  deleteph();
}

function valph(sel,text){
  var id = "err" + sel;
  var msg = $('<h4 id='+id+'><br>');
  $(msg).addClass("alerta");
  msg.addClass(id);
  msg.text(text);
  $('.phDiv').after(msg);
  console.log(msg);
  deleteErrPh();
}

function deleteErrPh(){
  setTimeout(function(){
    $(".errPh").remove();
    $(".errPhEmpty").remove();
  }, 2000);
}
function delPh(id){
  $("[telid=" + id + "]").remove();
  counter--;
  $("input[telid]:last").prop('readonly', false);
  $("button[telid]:last").show();
  //$("input[telid]:last").attr("disabled",false);
  $("button[telid]:last").css({"background-color": "#0C88FC"});
}
function deleteph(){
  setTimeout(function(){
    $(".errPh").remove();
    $(".errPhEmpty").remove();
  }, 2000);
}

function addPhEdit(phone){

  var id ='ph'+counter;
  var ph ='del'+counter;
  var ph = $("#"+id+"").val();

  if($(".tel:last").val() == '')
  {
    if($(".errPhEmpty").length == 0)
    valph("PhEmpty",'* Rellene el campo')
    return;
  }
  if(counter > 6)
  return;


  var input = $("<input>");
  var phdel = $("<button id='" + ph + "' telid='0" + counter + "' >");
  phdel.html("<i class='fa fa-times loading' telid='0" + counter + "' >");
  var br = $("<br telid='0" + counter + "'><br telid='0" + counter + "'>");
  phdel.addClass('phdel');
  input.addClass('tel');
  input.attr({
    type:"text",
    placeholder:"Ingrese telefono",
    maxlength:15,
    id:""+id,
    name:"phone",
    telid:"0"+counter
  });
  if(!phone == '')
  input.val(phone);
  counter++;


  $('.phDiv').append(br,input,phdel);
  deleteph();
}
