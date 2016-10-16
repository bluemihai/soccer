$(document).ready(function(){
  $('#players-table').DataTable({
      searching: false,
      paging: false,
    // columns: [
    //   { "type": "numeric" },
    //   null,
    //   null,
    //   null,
    //   null
    // ]
      columnDefs: [
        { type: 'num' },
        { type: 'string' },
        {type: 'html'}
      ],
      order: [1, 'asc'],
      // pageLength: -1,
      // lengthMenu: [ [10, 15, 20, 25, -1], [10, 15, 20, 25, "All"] ],
      // language: { lengthMenu: "Display _MENU_ Badges" }
  });

  $('#team-roster').DataTable({
      searching: false,
      paging: false,
    // columns: [
    //   { "type": "numeric" },
    //   null,
    //   null,
    //   null,
    //   null
    // ]
      columnDefs: [
        { type: 'num' },
        { type: 'num' },
        {type: 'string'}
      ],
      order: [1, 'asc'],
      // pageLength: -1,
      // lengthMenu: [ [10, 15, 20, 25, -1], [10, 15, 20, 25, "All"] ],
      // language: { lengthMenu: "Display _MENU_ Badges" }
  });

});
