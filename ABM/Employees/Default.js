$(document).ready(() =>{
  $("form").submit(() => {
    $("tr").hide();
    $(".2").show(100);
    if($("tr").hide())
    {
      $("tr").show(15000)
    }

  });


  $("#search").autocomplete("ws/WS.asp",{

    width: $("#search").width()+25,
    scroll: true,
    scrollHeight: 220,
    matchContains: true,
    minChars: 1,
    delay: 400,
    extraParams: {doAction: 1},

    formatItem: "{EmployeeName}&nbsp;{EmployeeLastName}<br/> {EmployeeRoleName}<br/>",
    onItemSelect: function (li) {
      if (li && li.elementData) {
        //$("#SearchBtn").attr("class", "btnDisabled").val("Buscando...").removeAttr("onclick");
        location.href = 'details.asp?EmployeeID=' + li.elementData.EmployeeID;
        //$("#search").val(li.elementData.EmployeeDNI);
      } else
      return false;
    }
  });
});
