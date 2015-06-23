Meteor.startup () ->
  unless process.env.NODE_ENV == 'PRODUCTION'
    Factory.define 'vouchers', Vouchers,
      code: ()->
        makeid()
      status: 'fresh'

    if (Vouchers.find({}).count() == 0)
      console.log "SEED: (vouchers) Seeding with 1000 vouchers..."
      _(1000).times (n) ->
        Factory.create('vouchers')
      console.log "SEED: (vouchers) This didn't take too long."

makeid = ->
  text = ""
  possible = "0123456789";
  for i in [1..10]
    text += possible.charAt(Math.floor(Math.random() * possible.length))
  text
