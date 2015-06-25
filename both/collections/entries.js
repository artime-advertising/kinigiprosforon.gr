EntriesSchema = new SimpleSchema({
  firstName: {
    type: String
  },
  lastName: {
    type: String
  },
  mobilePhone: {
    type: String
  },
  landlinePhone: {
    type: String,
    optional: true
  },
  address: {
    type: String
  },
  city: {
    type: String
  },
  postalCode: {
    type: String
  },
  email: {
    type: String
  },
  createdAt: {
    type: Date
  }
});

Entries = new Mongo.Collection('entries');
Entries.attachSchema(EntriesSchema);

Entries.helpers({
  fullName: function fullName() {
    return this.firstName + ' ' + this.lastName
  }
});

Entries.before.insert(function (userId, doc) {
  doc.createdAt = Date.now();
});
