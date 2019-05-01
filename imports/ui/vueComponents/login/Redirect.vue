<template lang="pug">
.redirecting-message Redirecting....
</template>

<script lang="coffee">
import { loginHandler } from '/imports/ui/helpers/activeDirectoryLoginHelper.coffee'

export default
  mounted: ->
    console.log('redirecting')
    unless Meteor.isCordova
      { code, error } = @$route.query
      email = localStorage.activeDirectoryUserEmail
      aDId = localStorage.activeDirectoryId
      loginHandler.call(@, error, code, email, aDId)

</script>

<style lang="stylus" scoped>
.redirecting-message
  font-weight bold
  position fixed
  top 5px
  left 5px
</style>
