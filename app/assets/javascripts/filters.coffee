email_app.filter 'email', ->
  (input) ->
    newInput = eval(input)
    newInput.join(", ")
