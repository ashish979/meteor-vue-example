<template lang="pug">
div
  div(v-if='!(allSubsReady)') Loading...
  div(v-else='')
    p Hello {{hello}},
    br
    span The time is now: {{currentTime}}
    button(@click='updateTime') Update Time
</template>

<script lang="coffee">
import { Time } from '/imports/collections/Time.coffee'
export default
  computed:
    allSubsReady: ->
      subscriptionKeys = Object.keys(this.$subReady);
      subsReady = subscriptionKeys[0] != null;
      for i in subscriptionKeys.length
        key = subscriptionKeys[i]
        subsReady = subsReady && @$subReady[key]
      subsReady
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
