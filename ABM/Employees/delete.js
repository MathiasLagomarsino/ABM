$(document).ready(() =>{

  $("form").submit((e) => {
    valid=alerta();
    if(!valid)
    e.preventDefault();
  });
});
var a=0;

function alerta(){
  var alerta = $("<h4>");
  var valid= true;
  $(alerta).addClass("alerta");
  if ( $('#check').is(':checked') && a==0) {

    alerta.text("* ¿Estás seguro de eliminar al empleado?");
    var alerta1 = $("<h4>");
    $(alerta1).addClass("alerta1");
    alerta1.text("** Despues de confirmar de nuevo el empleado será eliminado de la base de datos en aproximadamente 10 dias ");
    if($('.alerta').length == 0 ){
      $('.checkDiv').append(alerta);
      $('.alerta').hide(0).fadeIn(400);
      $('.checkDiv').append(alerta1);
      $('.alerta1').hide(0).fadeIn(400);
      a=1;
      setTimeout(function(){
        $(".alerta").remove();
        $(".alerta1").remove();
      }, 4500);
    }
    return valid;
  }
  else
  {
    if($('.alerta').length == 0 ){
      alerta.text("* Debe de confirmar la eliminación");
      $('.checkDiv').append(alerta);
      $('.alerta').hide(0).fadeIn(400);
      setTimeout(function(){
        $(".alerta").remove();
      }, 3500);
      valid=false;
      return valid;
    }
  }}
