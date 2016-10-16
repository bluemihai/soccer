$(function(){
  $('#teams').DataTable({
    searching: false,
    paging: false,
    order: [1, 'asc']
  })

  fillPositions()

  $('.bench-player')
    .draggable({helper: 'clone'})
    .droppable({
      drop: function( event, ui ) {
        swapPlayers(this, ui.draggable);
      }
    });
    
  $('#ball').draggable({
    helper: 'clone'
  })
})


var fillPositions = function() {
  $.get('/teams/23/lineup.json', function(data) {
    for (pos in data) {
      $('#pos' + pos).append('<br><b>' + data[pos] + '</b>')
    }
  })
}

var getPlayers = function() {
  $.get('/teams/23/players.json', function(data) {
    console.log('getting data...', data)
    return data
  });
}

var swapPlayers = function(incomingBenchElem, outgoingFieldElem) {
  incomingName = $(incomingBenchElem).html().split('<br>')[1]
  outgoingName = $(outgoingFieldElem).html().split('<br>')[1]
  position = $(outgoingFieldElem).html().split('<br>')[0]

  console.log('Swapping', incomingName)
  console.log('...for', outgoingName)
  console.log('...at', position)

  updateField(outgoingFieldElem, position, incomingName);
  updateBench(incomingBenchElem, outgoingName);
}

var updateField = function(outgoingFieldElem, position, incomingName) {
  $(outgoingFieldElem)
    .html(position + '<br>' + incomingName);
}

var updateBench = function(incomingBenchElem, outgoingName) {
  $(incomingBenchElem)
    .empty()
    .html(getPosition(outgoingName) + '<br>' + outgoingName)
}

