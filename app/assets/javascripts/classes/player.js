// class Player {
//   constructor(data) {
//     this.first_initial_last = data.first_initial_last
//     this.first_name = data.first_name
//     this.id = data.id
//     this.photo_url = data.photo_url
//     this.position = data.position
//     this.position_request = data.position_request
//     this.primary_position = data.primary_position
//     this.safe_name = data.safe_name
//     this.url = data.url
//     this.place()
//   }
//
//   place() {
//     if (this.position === -1) {
//       if (showNonRoster) {
//         var $box = "<div class='bench-player inactive id=p" + this.id +"'>" + this.position_request + "<br/>" + playerLink(this) + "</div>"
//         $('#nonroster').append($($box).css('background-color', '#eeeeee').attr('player_id', this.id))
//       }
//     } else if (this.position === 0) {
//       $('#bench').append(this.benchBox())
//     } else if (this.position === null) {
//       $('#roster').append(this.rosterBox())
//     } else if (typeof this.position === 'number') {
//       this.fieldBox()
//     }
//   }
//
//   benchBox() {
//     return $('<div>')
//       .attr('id', '#p' + this.id)
//       .addClass('bench-player').addClass('bench').addClass('rbox')
//       .css('background', 'url("' + this.photo_url + '")')
//       .css('background-repeat', 'no-repeat')
//       .css('background-size', '40px 40px')
//       .css('background-color', '#ddd')
//       .append('<br/>' + playerLink(this))
//       .attr('player_id', this.id)
//       .html(this.position_request + "<br/>" + playerLink(this))
//   }
//
//   rosterBox() {
//     return $('<div>')
//       .attr('id', '#p' + this.id)
//       .addClass('bench-player').addClass('roster').addClass('rbox')
//       .css('background', 'url("' + this.photo_url + '")')
//       .css('background-repeat', 'no-repeat')
//       .css('background-size', '40px 40px')
//       .css('background-color', '#ddd')
//       .append('<br/>' + playerLink(this))
//       .attr('player_id', this.id)
//       .html(this.position_request + "<br/>" + playerLink(this))
//   }
//
//   fieldBox() {
//     var color = $('#pos' + this.position).css('background-color')
//     return $('#pos' + this.position)
//       .css('background', 'url("' + this.photo_url + '")')
//       .css('background-repeat', 'no-repeat')
//       .css('background-size', '40px 40px')
//       .css('background-color', color)
//       .append('<br/>' + playerLink(this))
//       .attr('player_id', this.id)
//   }
// }
