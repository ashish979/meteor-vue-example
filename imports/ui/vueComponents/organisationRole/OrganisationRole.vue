<template lang='pug'>
v-card.pa-3.mt-2.role.card-panel(:hover='true')
  | {{role.name}}
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'

export default
  props: ['role']
</script>

<style lang='stylus' scoped>
  a
    text-decoration: none
</style>
