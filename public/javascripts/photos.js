$(document).ready(function() {
  
  $('#photo_list img').livequery(function() {
    $(this).fadeTo('slow', 0.3);
    $(this).hover(function() {
      $(this).fadeTo('slow', 1.0);
    },
    function() {
      $(this).fadeTo('slow', 0.3);
    });
  });
  
  $('#photo img').livequery(function() {
    $(this).fadeIn('slow');
  });
  
});