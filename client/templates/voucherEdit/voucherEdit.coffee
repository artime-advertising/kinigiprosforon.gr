Template.voucherEdit.helpers
  voucher: ->
    Vouchers.findOne()
  gift: ->
    Gifts.findOne()
  voucher_is_claimed: ->
    voucher = Vouchers.findOne({})
    voucher.status == 'claimed'
  voucher_is_completed: ->
    voucher = Vouchers.findOne({})
    voucher.status == 'completed'
