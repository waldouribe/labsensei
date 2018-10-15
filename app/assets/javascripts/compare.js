var ready = function(){
  var $firstInput = $('#compare_parameter_kind_id_1');
  var $secondInput = $('#compare_parameter_kind_id_2');
  var $submitButton = $('form.compare input:submit');

  if($firstInput.val()) { // Checking if input exists to execute initial scripts
    checkFirstInput();
    getComparableParameters($secondInput.val());
    checkSubmitButtonOperability();
  }

  $firstInput.change(function() {
    checkFirstInput();
    getComparableParameters();
    checkSubmitButtonOperability();
  });

  $secondInput.change(function() {
    checkSubmitButtonOperability();
  });

  function checkFirstInput() {
    if(!$firstInput.val()) {
      $secondInput.prop('disabled', true);
    } else {
      $secondInput.prop('disabled', false);
    }
  }

  function getComparableParameters(selected_parameter_id) {
    $.ajax( "get_comparable_parameters/" + $firstInput.val() + '?selected_parameter_id=' + selected_parameter_id)
    .done(function(data) {
      $secondInput.html(data);
      console.log( data );
    })
    .fail(function(error) {
      console.log( error );
    })
    .always(function() {
      console.log( "complete" );
    });
  }

  function checkSubmitButtonOperability() {
    if(!$firstInput.val() || !$secondInput.val()) {
      $submitButton.prop('disabled', true);
    } else {
      $submitButton.prop('disabled', false);
    }
  }
};


$(document).ready(ready);
$(document).on('page:load', ready);
