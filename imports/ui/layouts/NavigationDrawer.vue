<template lang='pug'>
v-navigation-drawer(fixed v-model="drawer" app)
  v-list
    navigation-links-for-super-admin(v-if='isSuperAdmin')
    common-links-for-all-users(v-if='loggedIn')
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'

#components
import NavigationLinksForSuperAdmin from './NavigationLinksForSuperAdmin.vue'
import CommonLinksForAllUsers from './CommonLinksForAllUsers.vue'

currentUser = -> Meteor.user()

export default
  data: ->
    drawer: null

  meteor:
    loggedIn: -> currentUser()?
    isSuperAdmin: -> currentUser()?.isSuperAdmin()

  components:
    'navigation-links-for-super-admin': NavigationLinksForSuperAdmin
    'common-links-for-all-users': CommonLinksForAllUsers
</script>

<style lang='stylus'>
.navigation-drawer
  .list
    .logo
      a
        height: 64px
        text-overflow: ellipsis

        .list__tile__content
          img
            margin-top: 5px
            width: 90px
            margin: auto
</style>
