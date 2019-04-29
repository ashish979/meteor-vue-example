<template lang="pug">
span About this project {{ itext }}
</template>

<script lang="coffee">
import { Meteor } from 'meteor/meteor'
import { Organisation } from '/imports/collections/Organisation.coffee'

export default
  data: ->
    abc: 'OrgCount '

  meteor:
    count: -> Organisation.find({}).count()
    itext: -> "#{@abc}-#{@count}"
</script>
