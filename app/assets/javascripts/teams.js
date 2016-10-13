$(function(){
  $('#teams').DataTable({
    searching: false,
    paging: false,
    order: [1, 'asc']
  })

  var players = $.get('/teams/23/players.json', function(data) {
    console.log(data)
  });
})