Template.voucherEdit.helpers
  voucher: ->
    Vouchers.findOne()
  gift: ->
    Gifts.findOne() || {}
  voucher_is_claimed: ->
    voucher = Vouchers.findOne({})
    voucher.status == 'claimed'
  voucher_is_awarded: ->
    voucher = Vouchers.findOne({})
    voucher.status == 'completed' && typeof voucher.gift != 'undefined'
  voucher_is_not_winning: ->
    voucher = Vouchers.findOne({})
    voucher.status == 'completed' && typeof voucher.gift == 'undefined'
