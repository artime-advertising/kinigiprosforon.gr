Meteor.methods
  'Vouchers.claim': (params) ->
    voucher = Vouchers.findOne({code: params.voucherCode})
    result = false
    getsReward = shouldGetPrize()

    if voucher and shouldGetPrize
      available_gifts_count = Gifts.find({voucher: {$exists: false} }).count()
      random_gift = Gifts.findOne({voucher: {$exists: false} }, {skip: _.random(0, available_gifts_count )})
      selected_gift = voucher.gift || random_gift

      Vouchers.update voucher._id,
        $set:
          status: "claimed"
          gift: selected_gift._id
          claimedAt: new Date

      Vouchers.findOne({_id: voucher._id}, {fields: {status: 1, claimedAt: 1, code: 1}})
    else
      false

  'Vouchers.unclaim': (params) ->
    voucher = Vouchers.findOne({code: params.voucherCode})
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
