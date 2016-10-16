width = 1150
height = 720
boxWidth = 100
boxHeight = 50

$(function(){
  displayPositions();
});

var displayPositions = function(data) {
  console.log('w', fieldWidth(), 'h', fieldHeight(), 'formation', getFormation())

  $('#field').empty();
  $.get('/' + getFormation() + '.json', function(data) {
    $.each(data, function(i, d) {
      var pos = { 
        left: Math.round(d[0] / 36 * width),
        top: Math.round(((d[1] + 6) / 14) * height + boxHeight / 2)
      };
      // console.log(i, pos);

      $('#field').append(
        $('<div>')
          .attr('id', 'pos' + i)
          .addClass('pbox')
          .css('background-color', d[4])
          .width( boxWidth )
          .height( boxHeight )
          .text('#' + i + '/' + d[3])
          .offset( pos )
      );
    });
    $(".pbox").draggable();
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