// var width = 1150
// var height = 720
// var boxWidth = 110
// var boxHeight = 40
// var displayOpponents = true
//
// $(function(){
//   displayPositions()
//   placeOpponents()
//   console.log('WORKING');
//   $('#toggle-opponents').on('click', function() {
//     toggleOpponents();
//   });
// });
//
// var toggleOpponents = function() {
//   console.log('displayOpponents is', displayOpponents);
//   if (displayOpponents) {
//     var $opponents = $('.opponent')
//     $opponents.each(function(idx){
//       opp = $opponents(idx)
//       console.log('opp', opp);
//       opp.hide();
//     })
//     displayOpponents = false
//   } else {
//     // $('.opponent').each(function(item){
//     //   item.show();
//     // })
//     // displayOpponents = true
//   }
// }
//
// var displayPositions = function(data) {
//   $('#field').empty();
//   $.get('/' + getFormation() + '.json', function(data) {
//     $.each(data, function(i, d) {
//       var pos = {
//         left: Math.round(d[0] / 36 * width),
//         top: Math.round(((d[1] + 6) / 14) * height + boxHeight / 2)
//       };
//
//       var box = $('<div>')
//           .attr('id', 'pos' + i)
//           .addClass('pbox')
//           .css('background', "url(/assets/blank_person.png) no-repeat")
//           .css('background-color', d[4])
//           .width( boxWidth )
//           .height( boxHeight )
//           .text('#' + i + '/' + d[3])
//           .offset( pos )
//       $('#field').append(box)
//     });
//
//     console.log('Running');
//     $(".pbox")
//       .draggable({
//         containment: $('#field'),
//         revert: function(dropped) {
//           return !!dropped
//         }
//       })
//       .droppable({
//         drop: function( event, ui ) {
//           var isSubstitution = ui.draggable.hasClass("bench-player");
//           console.log('isSubstitution', isSubstitution);
//           if (isSubstitution) {
//             swapPlayers(ui.draggable, this)
//           } else {
//             swapPositions(ui.draggable, this)
//           }
//         },
//         accept: '.pbox, .sub, .rbox',
//         hoverClass: 'receive'
//       })
//       ;
//   });
// }
//
// var placeOpponents = function() {
//   var formation = '442'
//   var oppBoxHeight = 40
//   var oppBoxWidth = 60
//   $.get('/' + formation + '.json', function(data) {
//     $.each(data, function(i, d) {
//       var pos = {
//         left: width - 400 - Math.round(d[0] / 36 * width),
//         top: height - 63 - Math.round(((d[1] + 6) / 14) * height + oppBoxHeight / 2)
//       }
//
//       var box = $('<div>')
//         .attr('id', 'opponent-' + i)
//         .addClass('opponent')
//         .width( oppBoxWidth )
//         .height( oppBoxHeight )
//         .text('#' + i + '/' + d[3])
//         .offset( pos )
//       $('#field').append(box)
//     })
//     $('.opponent').draggable({ containment: $('#field') })
//   })
// }
//
// var swapPositions = function(a, b) {
//   console.log('Running swapPositions...');
//   var aElements = $(a).html().split('<br>')
//   var bElements = $(b).html().split('<br>')
//   var aBackgroundImage = $(a).css('background-image')
//   $(a).html(aElements[0] + '<br>' + bElements[1])
//   $(b).html(bElements[0] + '<br>' + aElements[1])
//   $(a).css('background-image', $(b).css('background-image'))
//   $(b).css('background-image', aBackgroundImage)
//   $('#persist-lineup').prop('disabled', false);
// }
//
// var fieldHeight = function() {
//   var h = $('#field').height();
//   return h;
// }
//
// var fieldWidth = function() {
//   return $('#field').width();
// }
//
// var getFormation = function() {
//   var formation_class = $('#field').attr("class") || '4231'
//   return formation_class.split(' ')[0]
// }
//
// var getPositions = function(playerFirstName) {
//   var positions
//   $.get('/teams/23/players.json', function(players) {
//     for (var idx in players) {
//       var player = players[idx]
//       if (player.first_name === playerFirstName) {
//         positions = player.position_request
//       } else {
//       }
//     }
//     positions = 'N/A'
//   });
//   return positions;
// }
//
//
// var getPhotoUrl = function(playerFirstName) {
//   var photoUrl
//   $.get('/teams/23/players.json', function(players) {
//     for (var idx in players) {
//       var player = players[idx]
//       alert('hi')
//       if (player.first_name === playerFirstName) {
//         photoUrl = player.phot_url
//       } else {
//       }
//     }
//     photoUrl = 'N/A'
//   });
//   return photoUrl;
// }
