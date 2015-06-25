Meteor.publishComposite("vouchers", function(params) {
  return {
    find: function() {
      return Vouchers.find(params);
    },
    children: [
      {
        find: function (voucher) {
          return Gifts.find({_id: voucher.gift});
        }
      }
    ]
  }
});
