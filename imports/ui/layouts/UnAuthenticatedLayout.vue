<template lang='pug'>
v-content
  v-container.unauthenticated-layout(fill-height v-if="noRedirectHome")
    router-view
</template>

<script lang="coffee">
export default
  computed:
    noRedirectHome: ->
      if @isLoggedIn
        @$router.push({name: 'App.Home'})
        false
      else
        true

  meteor:
    isLoggedIn: ->
      Meteor.userId()?
</script>
<style lang="stylus">
  .unauthenticated-layout
    padding: unset
</style>

