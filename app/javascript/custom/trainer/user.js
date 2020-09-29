$(document).on('turbolinks:load', function (){
  $('#reset-form').on('click', function (){
    $('#search-form').trigger('reset');
    $('#btn-submit-search').click();
  });
});
