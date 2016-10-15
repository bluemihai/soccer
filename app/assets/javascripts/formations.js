$(function(){
  $(window).resize(displayPositions)

  displayPositions();
});

var displayPositions = function(data) {
  console.log('w', getWidth(), 'h', getHeight(), 'formation', getFormation())

  $('#field').empty();
  $.get('/' + getFormation() + '.json', function(data) {
    $.each(data, function(i, d) {
      var pos = { 
        left: Math.round(d[0] / 24 * getWidth()),
        top: Math.round(((d[1] + 6) / 11.45) * getHeight())
      };
      // console.log(i, pos);

      $('#field').append(
        $('<div>')
          .attr('id', 'pos' + i)
          .addClass("pbox")
          .offset( pos )
          .width( getWidth() / 24 * 3)
          .height( getHeight() / 13)
          .text('#' + i + '/' + d[3] + 'left: ' + pos['left'] + 'top: ' + pos['top'])
      );
    });
  });
}

var getHeight = function() {
  return $('#field').height();
}

var getWidth = function() {
  return $('#field').width();
}

var getFormation = function() {
  var formation_class = $('#field').attr("class") || '4231'
  return formation_class.split(' ')[0]
}