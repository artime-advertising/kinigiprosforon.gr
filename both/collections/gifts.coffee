giftSchema = new SimpleSchema
  name:
    type: String

@Gifts = new Mongo.Collection('gifts')
@Gifts.attachSchema giftSchema

@Gifts.helpers({})
