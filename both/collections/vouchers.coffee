voucherSchema = new SimpleSchema
  code:
    type: String
    label: "Code"
    min: 10
    max: 10
    unique: true
    index: true
  status:
    type: String
    allowedValues: ['fresh', 'claimed', 'completed']
  entry:
    type: String
    optional: true
  gift:
    type: String
    optional: true
  claimedAt:
    type: Date
    optional: true

@Vouchers = new Mongo.Collection('vouchers')
@Vouchers.attachSchema voucherSchema

@Vouchers.helpers({})

if Meteor.isServer
  @Vouchers.before.update (userId, doc, fieldNames, modifier, options) ->
    if _.findKey(modifier, 'gift') is '$set'
      Gifts.update modifier.$set.gift,
        $set:
          voucher: doc._id

    if _.findKey(modifier, {gift: ''}) is '$unset'
      Gifts.update doc.gift,
        $unset:
          voucher: ""
