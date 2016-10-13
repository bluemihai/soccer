$(function(){
  h = $('#field').height();
  w = $('#field').width();

  formation = $('#field').attr("class").split(' ')[0];
  $.get('/assets/' + formation + '.json',
  function(data) {
    //console.log("Hello");
    //console.log( data);
    // $('#field').empty();
    $.each(data, function(i, d) {
      var pos = { 
              left: d[0] / 24 * w,
              top: ((d[1] + 6) / 11.45) * h
            };
            // console.log(d);
            // console.log(pos);
            
      $('#field').append(
          $('<div>')
            .addClass("pbox")
            .offset( pos )
            .width( h / 24 * 4)
            .height( h / 13)
            .text('#' + i + '/' + d[3])
          );
      
    });
  });
})