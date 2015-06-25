Meteor.startup () ->
  Settings.upsert({key: 'Gift Multiplier'}, {$set: {key: 'Gift Multiplier', value: 1}})
