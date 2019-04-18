import { Time } from '/imports/collections/Time.coffee'

Meteor.publish('Time',() ->
  Time.find({})
)
