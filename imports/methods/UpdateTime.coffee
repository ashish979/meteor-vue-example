import { Time } from '/imports/collections/Time.coffee'

Meteor.methods UpdateTime: ->
  Time.upsert 'currentTime', $set: time: new Date
  return
