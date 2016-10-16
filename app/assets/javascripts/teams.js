$(function(){
  $('#teams').DataTable({
    searching: false,
    paging: false,
    order: [1, 'asc']
  })

  var players = $.get('/teams/23/players.json', function(data) {
  });

  fillPositions()

  $(".bench-player").draggable();
  $(".pbox").draggable();
  // $(".pbox div").droppable({
  //   drop: function( event, ui ) {
  //     console.log($(this))
  //     alert('Running!')
  //     $( this )
  //       .append(ui.draggable);
  //   }
  // });

})


var fillPositions = function() {
  $.get('/teams/23/lineup.json', function(data) {
    for (pos in data) {
      $('#pos' + pos).append('<br><b>' + data[pos] + '</b>')
    }
  })
}