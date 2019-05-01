<template lang='pug'>
.organisation-dashboard.scroll-container
  h1 {{ organisation.name }}
  v-layout.overflow-visible(row justify-center v-if='subscriptionsReady')
    v-flex.overflow-visible(xs12 md8 lg6)
      | List of users...
  loader(v-else)
</template>

<script lang='coffee'>
import Vue from 'vue'
import { Meteor } from 'meteor/meteor'
import { Organisations } from '/imports/api/organisations/collection.coffee'
import { Stocks } from '/imports/api/stocks/collection.coffee'

#components
import Loader from '/imports/ui/vueComponents/helperComponents/Loader.vue'
import _ from 'lodash'

export default
  computed:
    organisationId: -> @$route.params.id
    subscriptionsReady: ->
      !_.includes(@$subReady, false)

  components:
    'loader': Loader

  meteor:
    organisation: ->
      console.log('!!!!!!!!!!!!! inside organisation meteor method !!!!!!!!!!!!!!')
      Organisations.findOne(@organisationId)

    stockIds: -> (stock._id for stock in Stocks.find({organisationId: @organisationId}).fetch())

    $subscribe:
      'organisationUsers': ->
        [@organisationId, @stockIds]
</script>
