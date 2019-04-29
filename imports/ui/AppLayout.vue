<template lang="pug">
div
  div(v-if="allSubscriptionsReady")
    app-menu
    router-view
  div(v-else) Loading.....
</template>

<script lang="coffee">

import { Time } from '/imports/collections/Time.coffee'
import { Organisation } from '/imports/collections/Organisation.coffee'
import { _ } from 'lodash'
import AppMenu from './AppMenu.vue'

export default
  computed:
    allSubscriptionsReady: ->
      !_.includes(@$subReady, false)

  data: ->
    hello: 'World'
    settings: Meteor.settings.public

  methods:
    updateTime: ->
      console.log('Calling Meteor Method UpdateTime');
      Meteor.call('UpdateTime');

    insertOrganisation: ->
      Meteor.call('InsertOrganisation');

  meteor:
    $subscribe:
      'Time': []
      'Organisation': []
      'OrganisationData': -> [this.organisationIds]

    currentTime: ->
      console.log('Calculating currentTime');
      t = Time.findOne('currentTime') || {};
      t.time

    OrganisationCursor: ->
      Organisation.find({})

    organisationIds: ->
      @OrganisationCursor?.map((organisation) => organisation._id)

  components:
    'app-menu': AppMenu

</script>

<style scoped>
  p {
    font-size: 2em;
  }
</style>

