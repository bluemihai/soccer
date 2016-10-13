$(function(){
  $.get('/assets/4231.json',
  function(data) {
    //console.log("Hello");
    //console.log( data);
    $('#field').empty();
    $.each(data, function(i, d) {
      var pos = { 
              left: d[0] / 24 * $('#field').width(),
              top: ((d[1] + 6) / 12) * $('#field').height()
            };
            console.log(d);
            console.log(pos);
            
      $('#field').append(
          $('<div>')
            .addClass("pbox")
            .offset( pos )
            .width( $('#field').height() / 24 * 4)
            .height( $('#field').height() / 13)
            .text('' + i)
          );
      
    });
  });
})