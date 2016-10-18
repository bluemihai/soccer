$(function(){
  $('#teams').DataTable({
    searching: false,
    paging: false,
    order: [1, 'asc']
  })

  fillPositions()

  $('.bench-player')
    .draggable({
      helper: 'clone'
    })
    // .droppable({
    //   drop: function( event, ui ) {
    //     swapPlayers(this, ui.draggable);
    //   }
    // })

  $('#ball').draggable()
})


var fillPositions = function() {
  $.get('/teams/23/lineup.json', function(data) {
    for (pos in data) {
      $('#pos' + pos).append('<br><b>' + data[pos] + '</b>')
    }
  })
}


var swapPlayers = function(incomingBenchElem, outgoingFieldElem) {
  var incomingName = $(incomingBenchElem).html().split('<br>')[1]
  var outgoingName = $(outgoingFieldElem).html().split('<br>')[1]
  var position = $(outgoingFieldElem).html().split('<br>')[0]

  updateField(outgoingFieldElem, position, incomingName);

  var cleanFirstName = $(outgoingName).text()

  updateField(outgoingFieldElem, position, incomingName);

  $.get('/teams/23/players.json', function(players) {
    for (idx in players) {
      player = players[idx]
      if (player.first_name === cleanFirstName) {
        updateBench(incomingBenchElem, outgoingName, player.position_request);
      }
    }
    positions = 'N/A'
  });

}

var updateField = function(outgoingFieldElem, position, incomingName) {
  $(outgoingFieldElem)
    .html(position + '<br>' + incomingName);
}

var updateBench = function(incomingBenchElem, outgoingName, positions) {
  $(incomingBenchElem)
    .empty()
    .html(positions + '<br>' + outgoingName)
    .css('background-color', positionColors[positions.split(', ')[0]]);
}

var positionColors = {
  GK: '#aaaaaa',
  CB: 'cyan',
  WB: '#aaffaa',
  LWB: '#aaffaa',
  RWB: '#aaffaa',
  DM: 'yellow',
  AM: 'orange',
  RAM: 'orange',
  LAM: 'orange',
  CAM: '#ffaa66',
  S: '#ffaaaa'
}
