ready = ->
  $('[data-toggle="tooltip"]').tooltip()

  $.fn.editable.defaults.mode = 'inline'
  $('.editable').editable error: (response, newValue) ->
    if response.status == 500
      'Servicio no disponible. Por favor intente nuevamente.'
    else
      errorObj = JSON.parse(response.responseText)
      # Print array of errors separated by a newline.
      # NOTE: Only for first column, but x-editable only
      # edits one column at the moment so it's alright ;)
      errorObj[Object.keys(errorObj)[0]].join("\n")
  return

$(document).ready ready
$(document).on 'page:load', ready
