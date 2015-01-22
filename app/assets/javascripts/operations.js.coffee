class OperationApp
  constructor: ->
    @bindEvents()
    @toggleTransferDiv()

  bindEvents: ->
    $("input[name='operation[transaction_type]']").change(@toggleTransferDiv)

  toggleTransferDiv: (e) ->
    type = $("input[name='operation[transaction_type]']:checked").val()
    if "2" == type
      $("#transferDiv").show()
    else
      $("#transferDiv").hide()

$(document).on 'ready page:load', ->
  app = new OperationApp() if $(".operations.new").length
  
