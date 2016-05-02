$(document).ready(function(){
  $('#httpmethod').on('change', function(){
      $('#btn-verb').text($('#httpmethod').val()) 
  }); 
  
  $('#end_points').on('change', function(){
      $('#urlvalue').val($('#end_points').val()) 
  });
});
