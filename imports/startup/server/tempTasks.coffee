import { Meteor } from 'meteor/meteor'
import { NotificationMessages } from '/imports/api/notificationMessages/collection.coffee'
import _ from 'lodash'
import { AskedQuestions } from '/imports/api/askedQuestions/collection.coffee'

addOrganisationToNotificationMessages= ->
  userIds = findUserIdsWhoseNotificationMessagesDoNotHaveOrganisationId()
  if userIds.length > 0
    users = (Meteor.users.findOne({_id: userId}) for userId in userIds)
    updateNotificationMessagesOrganisationIdFor(user) for user in users
  console.log "userIds for which notification messages do not have organisationId: " + findUserIdsWhoseNotificationMessagesDoNotHaveOrganisationId()

updateNotificationMessagesOrganisationIdFor = (user)->
  NotificationMessages.update({userId: user._id}, { $set: { organisationId: user.currentOrganisationId()}}, {multi: true}) if user?

findUserIdsWhoseNotificationMessagesDoNotHaveOrganisationId = ->
  userIds = []
  userDocs = NotificationMessages.find({organisationId: {$exists: false}}, {fields: {userId: 1}}).fetch()
  userIds = (userDoc.userId for userDoc in userDocs)
  userIds = _.uniq(userIds)
  userIds

addAnsweredAtForAllAskedQuestions = ->
  askedQuestions = AskedQuestions.find({answeredAt: {'$exists': false}}).fetch()
  if askedQuestions
    for askedQuestion in askedQuestions
      AskedQuestions.update({_id: askedQuestion._id}, { $set: { answeredAt: askedQuestion.updatedAt }})

module.exports=
  addOrganisationToNotificationMessages: addOrganisationToNotificationMessages
  addAnsweredAtForAllAskedQuestions: addAnsweredAtForAllAskedQuestions