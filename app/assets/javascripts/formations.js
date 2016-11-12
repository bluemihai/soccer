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
      .draggable({
        containment: $('#field'),
        revert: function(dropped) {
          return !!dropped
        }
      })
      .droppable({
        drop: function( event, ui ) {
          var isSubstitution = ui.draggable.hasClass("bench-player");
          if (isSubstitution) {
            swapPlayers(ui.draggable, this)
          } else {
            swapPositions(ui.draggable, this)
          }
        },
        accept: '.pbox, .sub',
        hoverClass: 'receive'
      })
      ;

    
  });
}

var swapPositions = function(a, b) {
  aElements = $(a).html().split('<br>')
  bElements = $(b).html().split('<br>')
  $(a).html(aElements[0] + '<br>' + bElements[1])
  $(b).html(bElements[0] + '<br>' + aElements[1])
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
