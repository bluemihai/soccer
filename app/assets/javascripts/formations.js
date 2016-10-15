width = 1150
height = 720
boxWidth = 80
boxHeight = 40

$(function(){
  $(window).resize(displayPositions)

  displayPositions();
});

var displayPositions = function(data) {
  console.log('w', fieldWidth(), 'h', fieldHeight(), 'formation', getFormation())

  $('#field').empty();
  $.get('/' + getFormation() + '.json', function(data) {
    $.each(data, function(i, d) {
      var pos = { 
        left: Math.round(d[0] / 36 * width + boxWidth / 2),
        top: Math.round(((d[1] + 6) / 11.45) * height + boxHeight / 2)
      };
      // console.log(i, pos);

      $('#field').append(
        $('<div>')
          .attr('id', 'pos' + i)
          .addClass('pbox')
          .width( boxWidth )
          .height( boxHeight )
          .text('#' + i + '/' + d[3])
          .offset( pos )
      );
    });
  });
}

var fieldHeight = function() {
  h = $('#field').height();
  console.log('h', h)
  return h;
}

var fieldWidth = function() {
  return $('#field').width();
}

var getFormation = function() {
  var formation_class = $('#field').attr("class") || '4231'
  return formation_class.split(' ')[0]
}