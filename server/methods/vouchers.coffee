Future = Npm.require('fibers/future')

Meteor.methods
  'Vouchers.claim': (voucherCode) ->
    voucher = Vouchers.findOne({code: voucherCode})
    result = false
    getsReward = shouldGetPrize()

    if voucher and shouldGetPrize
      available_gifts_count = Gifts.find({voucher: {$exists: false} }).count()
      random_gift = Gifts.findOne({voucher: {$exists: false} }, {skip: _.random(0, available_gifts_count )})
      selected_gift = voucher.gift || random_gift

      future = new Future()
      Vouchers.update voucher._id,
        $set:
          status: "claimed"
          gift: selected_gift._id
          claimedAt: new Date
    else
      false

  'Vouchers.unclaim': (voucherCode) ->
    voucher = Vouchers.findOne({code: voucherCode})
    result = false
    if voucher and voucher.gift
      Vouchers.update voucher._id,
        $unset:
          gift: ""
          claimedAt: ""
        $set:
          status: "fresh"
    else
      false

shouldGetPrize = ->
  true
