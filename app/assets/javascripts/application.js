// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require jquery_ujs
//= require_tree .
//= require popper
//= require bootstrap
//= require Chart.min
//= require jquery-ui

$(document).ready(function() {
  var tableContent = $('#products').html();

  $('.main-search').keyup(debounce(function() {
    let testInput = $(this).val()

    $.get('/api/search', {key: testInput}, function(result) {
      let tags = [];
      for(let i in result)
        tags.push(result[i].name);
      $('#search').autocomplete({source: tags});

      $('#products').empty().append(tableContent);
      $('#products tr').each(function() {
        let exists = false;
        for (let i in result) {
          if($(this).attr('id') == result[i].id) {
            exists = true;
            break;
          }
        }
        if(!exists) {
          $(this).remove();
        }
      });
    })
  },300));
});

function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
};

function comment(id){
  var answer = prompt('Add a comment:');
  if (answer != null) {
    $('#comment'+id+' #comment_text').val(answer);
    $('#comment'+id).submit();
  }
}