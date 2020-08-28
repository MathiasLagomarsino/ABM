/*
···· Ejemplo de request ajax ····
···· Info: http://api.jquery.com/jquery.ajax/ ····
*/

var WS_URL = 'ejemplo-ajax.asp';//'ws.asp';
var SEPARATOR = '- - - - - - - - - - - - - - - - - - - - - -'


function doAjaxRequest(doAction, data1, data2, dataN){
    console.log(SEPARATOR);
    console.log("function doAjaxRequest(doAction, data1, data2, dataN)");
    console.log("doAction: " + doAction);
    console.log("data1: " + data1);
    console.log("data2: " + data2);
    console.log("dataN: " + dataN);
    console.log(SEPARATOR);
    Response.ContentType = "application/json"
response.Write "{ ""success"": ""1"", ""data"": {""doAction"": """ & doAction & """, ""data1"": """ & data1 & """, ""data2"": """ & data2 & """, ""dataN"": """ & dataN & """}}"
    $.ajax({
        url: WS_URL,
        async: false,
        //type:'post',
        type: "GET",
        dataType: "json",
        data: { 
            doAction: doAction, 
            param1: data1,
            param2: data2,
            paramN: dataN
        }
    })
    .done(function (data) {
        console.log(SEPARATOR);
        console.log("Gane!");
        console.log(data);
        console.log(SEPARATOR);
    })
    .fail(function (data) {
        console.log(SEPARATOR);
        console.log("Todo mal!");
        console.log(data);
        console.log(SEPARATOR);
    });    
}

$(document).ready(function(){
    doAjaxRequest("1", "value1", "value2", "valueN");
});