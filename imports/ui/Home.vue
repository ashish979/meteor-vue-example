<template lang="pug">
div
  div(v-if='allSubscriptionsReady')
    p Hello {{hello}},
    br
    span The time is now: {{currentTime}}
    button(@click='updateTime') Update Time
  div(v-else) Loading...
</template>

<script lang="coffee">
import { _ } from 'lodash'
import { Time } from '/imports/collections/Time.coffee'

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
  meteor:
    $subscribe:
      'Time': []
    currentTime: ->
      console.log('Calculating currentTime');
      t = Time.findOne('currentTime') || {};
      t.time
</script>

<style scoped>
  p {
    font-size: 2em;
  }
</style>
