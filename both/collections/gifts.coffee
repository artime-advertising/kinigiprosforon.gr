giftSchema = new SimpleSchema
  name:
    type: String
  voucher:
    type: String
    optional: true

@Gifts = new Mongo.Collection('gifts')
@Gifts.attachSchema giftSchema

@Gifts.helpers({})
