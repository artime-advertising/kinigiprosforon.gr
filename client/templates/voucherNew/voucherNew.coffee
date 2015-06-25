Template.voucherNew.helpers
  voucherNewSchema: ->
    new SimpleSchema
      voucherCode:
        type: String
        label: "Voucher code"
        min: 10
        max: 10

AutoForm.hooks
  voucherNewForm:
    onSuccess: (formType, result) ->
      unless result == false
        Router.go 'voucherEdit', {code: result.code}
      else
        Router.go '/gameOver'
