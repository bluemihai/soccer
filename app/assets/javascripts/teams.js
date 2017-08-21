$(function () {
  $('#teams').DataTable({
    searching: false,
    paging: false,
    order: [1, 'asc']
  })

  var persistedPlayers = {}
  fillPositions()

  $('#ball').draggable()
  $('.opponent').draggable()
  $('#persist-lineup').on('click', function () {
    collectCurrentRoster()
  })
})

var playerLink = function (playerObject) {
  var link = "<a href='/players/" + playerObject.id + "/edit'>"
    + playerObject.first_name + '</a>'
  return (playerObject.position > 0) ? '<b>' + link + '</b>' : link
}

var fillPositions = function () {
  $.get('/teams/23/players.json?include_inactive', function (players) {
    for (var idx in players) {
      var persistedPlayers = players
      var player = players[idx]
      let p = new Player(players[idx])
    }
    $('.bench-player')
      .draggable({
        helper: 'clone'
      })
      .droppable({
        drop: function (event, ui) {
          swapPlayers(this, ui.draggable)
        },
        hoverClass: 'receive'
      })
    return players
  })
  //
  // $.get('/teams/23/lineup.json', function(data) {
  //   for (pos in data) {
  //     $('#pos' + pos)
  //     .append(
  //       "<br><b><a href='/players/" + data[pos].id + "/edit'>"
  //       + data[pos].first_name + '</a></b>')
  //     .attr('player_id', data[pos].id)
  //   }
  // })
}

var swapPlayers = function (incomingBenchElem, outgoingFieldElem) {
  console.log('Running swapPlayers...')
  var incomingName = $(incomingBenchElem).html().split('<br>')[1]
  var outgoingName = $(outgoingFieldElem).html().split('<br>')[1]
  var position = $(outgoingFieldElem).html().split('<br>')[0]
  var incomingPhotoUrl = $(incomingBenchElem).css('background-image')
  var outgoingPhotoUrl = $(outgoingFieldElem).css('background-image')
  console.log('$(incomingFieldElem)', $(incomingBenchElem))
  console.log('photoUrls', incomingPhotoUrl, outgoingPhotoUrl)
  updateField(outgoingFieldElem, position, incomingName, incomingPhotoUrl)

  var cleanFirstName = $(outgoingName).text()

  $.get('/teams/23/players.json', function (players) {
    for (var idx in players) {
      var player = players[idx]
      if (player.first_name === cleanFirstName) {
        updateBench(incomingBenchElem, outgoingName, player.position_request, outgoingPhotoUrl)
      }
    }
    var positions = 'N/A'
  })
  $('#persist-lineup').prop('disabled', false)
}

var updateField = function (outgoingFieldElem, position, incomingName, incomingPhotoUrl) {
  $(outgoingFieldElem)
    .css('background', 'url("' + incomingPhotoUrl + '")')
    .css('background-repeat', 'no-repeat')
    .css('background-size', '40px 40px')
    .html(position + '<br>' + incomingName)
}

var updateBench = function (incomingBenchElem, outgoingName, positions, outgoingPhotoUrl) {
  $(incomingBenchElem)
    .css('background', 'url("' + outgoingPhotoUrl + '")')
    .css('background-repeat', 'no-repeat')
    .css('background-size', '40px 40px')
    .empty()
    .html(positions + '<br>' + outgoingName)
    .css('background-color', positionColors[positions.split(', ')[0]])
}

var persistLineup = function () {
  console.log('Okay, persisting lineup in js-land...')
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

var collectCurrentRoster = function () {
  var output = {starters: [], bench: [], roster: [], nonroster: []}
  var $starters = $('#field div')
  $starters.each(function (idx) {
    var pos = $($starters[idx]).attr('id').slice(3)
    output['starters'][pos] = $($starters[idx]).attr('player_id')
  })

  var $bench = $('#bench div')
  $bench.each(function (idx) {
    output.bench.push($($bench[idx]).attr('player_id'))
  })

  var $roster = $('#roster div')
  $roster.each(function (idx) {
    output.roster.push($($roster[idx]).attr('player_id'))
  })

  var $nonroster = $('#nonroster div')
  $nonroster.each(function (idx) {
    output.nonroster.push($($nonroster[idx]).attr('player_id'))
  })

  output.starters = output.starters.filter(function (n) { return n !== 'length' })
  output.bench = output.bench.filter(function (n) { return n !== undefined })
  output.roster = output.roster.filter(function (n) { return n !== undefined })
  output.nonroster = output.nonroster.filter(function (n) { return n !== undefined })

  console.log('output', output)
  $.post('/teams/23/players', output)
}
