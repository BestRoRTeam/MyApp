function checkBoxAction() {
  let id = $(this).attr('id');

  if($(this).is(":checked")) {
    $("#form"+id.substr(5)).css('display', 'table-cell');
  } else {
    $("#form"+id.substr(5)).css('display', 'none');
  }
}

$(document).ready(function() {
  $(".temp-check").each(function() {
    $(this).change(checkBoxAction);
  });

  $("#temp_submit").click(function(e) {
    let json = JSON.parse($("#json_data_input").val());
    let result = [];
    $.each(json, function(i, item){
      if($("#check"+item.id).is(":checked")) {
        item.price = $("#input_price"+item.id).val();
        item.shop = $("#input_shop").val();
        result.push(item);
      }
    });
    $("#json_data_input").val(JSON.stringify(result));
  })
});