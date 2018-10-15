var ready = function(){
  $('#has_institution_btn').click(function(){
    $('#has_institution_btn').addClass('active');
    $('#no_institution_btn').removeClass('active');

    $('.institution-form').removeClass( "hide" );
    $('.plans').addClass( "hide" );
  });

  $('#no_institution_btn').click(function(){
    $('#no_institution_btn').addClass('active');
    $('#has_institution_btn').removeClass('active');

    $('.plans').removeClass( "hide" );
    $('.institution-form').addClass( "hide" );
  });

  $( "#user_institution_id" ).change(function() {
    if($(this).val() !== '') {
      $('#institution_submit_button').prop('disabled', false);
    } else {
      $('#institution_submit_button').prop('disabled', true);
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
