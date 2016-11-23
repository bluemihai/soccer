$(function(){
  $('#teams').DataTable({
    searching: false,
    paging: false,
    order: [1, 'asc']
  })

  var persistedPlayers = {};
  fillPositions()

  $('#ball').draggable();
  $('#persist-lineup').on('click', function() {
    collectCurrentRoster();
  })
})

var playerLink = function(playerObject) {
  var link = "<a href='/players/" + playerObject.id + "/edit'>"
    + playerObject.first_name + "</a>"
  return (playerObject.position > 0) ? '<b>' + link + '</b>' : link
}

var fillPositions = function() {
  var colors = {
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
  };
  
  $.get('/teams/23/players.json?include_inactive', function(players) {
    for (var idx in players) {
      var persistedPlayers = players;
      var player = players[idx];
      var pos = player.position;
      if (pos === -1) {
        var $box = "<div class='bench-player inactive'>" + player.position_request + "<br/>" + playerLink(player) + "</div>"
        $('#nonroster').append($($box).css('background-color', '#eeeeee').attr('player_id', player.id))
      } else if (pos === 0) {
        var $box = "<div class='bench-player sub'>" + player.position_request + "<br/>" + playerLink(player) + "</div>"
        $('#bench').append($($box).css('background-color', colors[player.primary_position]).attr('player_id', player.id))
      } else if (pos === null) {
        var $box = "<div class='bench-player roster'>" + player.position_request + "<br/>" + playerLink(player) + "</div>"
        $('#roster').append($($box).css('background-color', '#dddddd').attr('player_id', player.id))
      } else if (typeof pos === 'number') {
        $('#pos' + pos).append('<br/>' + playerLink(player)).attr('player_id', player.id)
      }
    }
    $('.bench-player')
      .draggable({
        helper: 'clone'
      })
      .droppable({
        drop: function( event, ui ) {
          swapPlayers(this, ui.draggable);
        },
        hoverClass: 'receive'
      })
    console.log('players', players);
    return players;
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

var swapPlayers = function(incomingBenchElem, outgoingFieldElem) {
  var incomingName = $(incomingBenchElem).html().split('<br>')[1]
  var outgoingName = $(outgoingFieldElem).html().split('<br>')[1]
  var position = $(outgoingFieldElem).html().split('<br>')[0]

  updateField(outgoingFieldElem, position, incomingName);

  var cleanFirstName = $(outgoingName).text()

  updateField(outgoingFieldElem, position, incomingName);

  $.get('/teams/23/players.json', function(players) {
    for (var idx in players) {
      var player = players[idx]
      if (player.first_name === cleanFirstName) {
        updateBench(incomingBenchElem, outgoingName, player.position_request);
      }
    }
    var positions = 'N/A'
  });
  $('#persist-lineup').prop('disabled', false);
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

var persistLineup = function() {
  console.log('Okay, persisting lineup in js-land...');
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

var collectCurrentRoster = function() {
  var output = {starters: [], bench: [], roster: [], nonroster: []}
  var $starters = $('#field div')
  $starters.each(idx => {
    var pos = $($starters[idx]).attr('id').slice(3)
    output['starters'][pos] = $($starters[idx]).attr('player_id')
  })

  var $bench = $('#bench div')
  $bench.each(idx => {
    output.bench.push($($bench[idx]).attr('player_id'))
  })

  var $roster = $('#roster div')
  $roster.each(idx => {
    output.roster.push($($roster[idx]).attr('player_id'))
  })

  var $nonroster = $('#nonroster div')
  $nonroster.each(idx => {
    output.nonroster.push($($nonroster[idx]).attr('player_id'))
  })

  output.starters = output.starters.filter(function(n){ return n !== 'length' });
  output.bench = output.bench.filter(function(n){ return n !== undefined });
  output.roster = output.roster.filter(function(n){ return n !== undefined });
  output.nonroster = output.nonroster.filter(function(n){ return n !== undefined });

  console.log('output', output);
  $.post('/teams/23/players', output)
}