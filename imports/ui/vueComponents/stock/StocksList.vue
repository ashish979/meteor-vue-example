<template lang='pug'>
.stocks-list.overflow-visible.scroll-container(v-if='canView')
  h1 Stocks
  .draggable-stocks.overflow-visible
    stock(v-for='_stock in stocks' :key="_stock._id" :stock='_stock')
.card-panel.red-text(v-else) Permission Denied
</template>

<script lang="coffee">
import { Meteor } from 'meteor/meteor'
import { Stocks } from '/imports/api/stocks/collection.coffee'

#components

import Stock from './Stock.vue'

export default
  meteor:
    canView: -> Meteor.user().isSuperAdmin() or Meteor.user().isOrganisationAdmin()
    stocks: ->
      Stocks.find({organisationId: Meteor.user().currentOrganisationId()}, {sort: {name: 1}})

  components:
    'stock': Stock
</script>
