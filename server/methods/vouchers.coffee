Meteor.methods
  'Vouchers.claim': (voucherCode) ->
    voucher = Vouchers.findOne({code: voucherCode})
    getsReward = shouldGetPrize()

    if voucher and shouldGetPrize
      available_gifts_count = Gifts.find({voucher: {$exists: false} }).count()
      random_gift = Gifts.findOne({voucher: {$exists: false} }, {skip: _.random(0, available_gifts_count )})
      selected_gift = voucher.gift || random_gift

      console.log random_gift, selected_gift, voucher

      Vouchers.update voucher._id,
        $set:
          status: "claimed"
          gift: selected_gift._id
          claimedAt: new Date
      , () ->
        Gifts.update selected_gift._id,
          $set:
            voucher: voucher._id
        , () -> true

    else
      false

shouldGetPrize = ->
  true
