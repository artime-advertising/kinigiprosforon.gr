AvailableGifts = [
  "GIFT 1",
  "GIFT 2",
  "GIFT 3",
  "GIFT 4",
  "GIFT 5"
]


Meteor.startup () ->
  unless process.env.NODE_ENV == 'PRODUCTION'
    Factory.define 'gifts', Gifts,
      name: ()->
        _.sample AvailableGifts

    if (Gifts.find({}).count() == 0)
      console.log "SEED: (gifts) Seeding with 100 gifts..."
      _(100).times (n) ->
        Factory.create('gifts')
      console.log "SEED: (Gifts) This did take too long."
