<template lang='pug'>
v-progress-circular(indeterminate color="primary" v-if='userRedirect')
v-card.pa-2.ma-3.card-panel(v-else)
  p Thanks for signing up {{displayName}}.
  | It doesn't look like you have been assigned to an Organisation yet.
  | If this is unexpected, please contact your organisation's Peopability administrator.
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'

currentUser = -> Meteor.user()

export default
  meteor:
    currentOrganisation: -> currentUser()?.currentOrganisation()
    currentOrganisationUrl: -> "/organisations/#{}"
    userRedirect: ->
      if currentUser()?.isSuperAdmin() and not @currentOrganisation?
        @$router.push({name: 'Organisations.list'})
        true
      else if currentUser()?.isAdmin()
        @$router.push({name: 'Organisations.dashboard', params: {id: @currentOrganisation?._id}})
        true
      else if @currentOrganisation?
        @$router.push({name: 'Learner.dashboard'})
        true
      else
        false

    displayName: ->
      currentUser()?.primaryEmail()
</script>
