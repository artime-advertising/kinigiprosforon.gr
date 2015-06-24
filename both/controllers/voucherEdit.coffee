@voucherEditController = AppController.extend
  waitOn: () ->
    Vouchers.findOne({code: @params.id})
