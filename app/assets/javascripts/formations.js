width = 1150
height = 720
boxWidth = 100
boxHeight = 50

$(function(){
  displayPositions();
});

var displayPositions = function(data) {

  $('#field').empty();
  $.get('/' + getFormation() + '.json', function(data) {
    $.each(data, function(i, d) {
      var pos = { 
        left: Math.round(d[0] / 36 * width),
        top: Math.round(((d[1] + 6) / 14) * height + boxHeight / 2)
      };

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

    $(".pbox")
      .draggable()
      .droppable({
        drop: function( event, ui ) {
          swapPlayers(ui.draggable, this)
      }
    });

    
  });
}

var fieldHeight = function() {
  h = $('#field').height();
  return h;
}

var fieldWidth = function() {
  return $('#field').width();
}

var getFormation = function() {
  var formation_class = $('#field').attr("class") || '4231'
  return formation_class.split(' ')[0]
}

var getPositions = function(playerFirstName) {
  var positions
  $.get('/teams/23/players.json', function(players) {
    for (idx in players) {
      player = players[idx]
      if (player.first_name === playerFirstName) {
        positions = player.position_request
      } else {
      }
    }
    positions = 'N/A'
  });
  return positions;
}
