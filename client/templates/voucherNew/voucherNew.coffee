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
      if result.status == "claimed"
        Router.go 'voucherEdit', {code: result.code}
