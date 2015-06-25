Meteor.methods
  'Vouchers.claim': (params) ->
    voucher = Vouchers.findOne({code: params.voucherCode})

    if voucher
      if voucher.status == 'fresh'
        available_gifts_count = Gifts.find({voucher: {$exists: false} }).count()
        random_gift = Gifts.findOne({voucher: {$exists: false} }, {skip: _.random(0, available_gifts_count )})
        selected_gift = voucher.gift || random_gift
        if shouldGetPrize()
          Vouchers.update voucher._id,
            $set:
              status: "claimed"
              gift: selected_gift._id
              claimedAt: new Date
        else
          Vouchers.update voucher._id,
            $set:
              status: "completed"
              claimedAt: new Date
      Vouchers.findOne({_id: voucher._id}, {fields: {status: 1, claimedAt: 1, code: 1}})
    else
      false

  'Vouchers.unclaim': (params) ->
    voucher = Vouchers.findOne({code: params.voucherCode, status: "claimed"})
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
  availableVouchers = Vouchers.find({status: "fresh"}).count()
  availableGifts = Gifts.find({voucher: {$exists: false} }).count()
  giftMultiplier = Settings.findOne({key: 'Gift Multiplier'}).value

  chance = (1 / (availableVouchers / (availableGifts * giftMultiplier)))
  chance >= Math.random() ? true : false
