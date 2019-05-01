<template lang="pug">
v-toolbar(flat fixed class="top-nav" :prominent='true')
  v-toolbar-side-icon(@click.stop='toggleDrawer')
  v-spacer
  .nav-content.overflow-visible(v-if="hasSignedIn")
    v-btn(href='#' flat icon class="notification-icon overflow-visible")
</template>

<script lang="coffee">
export default
  meteor:
    hasSignedIn: ->
      Meteor.user()?
  methods:
    toggleDrawer: ->
      @$emit('toggle-navigation-drawer')
</script>

<style lang="stylus">
nav.top-nav
  .toolbar__content
    box-shadow none

  .notification-icon
    i
      font-size 2.7rem
  .notifications-menu
    .menu__activator
      overflow visible
      .notification-icon
        .btn__content
          overflow visible

@media only screen and (min-width : 993px)
  .toolbar__content
    .toolbar__side-icon
      display: none
</style>
