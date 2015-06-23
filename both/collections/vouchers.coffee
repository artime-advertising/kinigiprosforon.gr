voucherSchema = new SimpleSchema
  code:
    type: String
    label: "Code"
    min: 10
    max: 10
  status:
    type: String
    allowedValues: ['fresh', 'claimed', 'completed']
  entry:
    type: String
    optional: true

@Vouchers = new Mongo.Collection('vouchers')
@Vouchers.attachSchema voucherSchema

@Vouchers.helpers({})
