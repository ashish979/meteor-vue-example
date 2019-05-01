<template lang='pug'>
.authenticated-layout(v-if="noLoginRedirect")
  navigation-drawer(ref='drawer')
  nav-bar(@toggle-navigation-drawer='toggleNavigationDrawer')
  v-content
    v-container.content-container(v-if="allSubscriptionsReady")
      router-view(ref='content')
    loader(v-else)
</template>

<script lang='coffee'>
import NavBar from './NavBar.vue'
import NavigationDrawer from '/imports/ui/layouts/NavigationDrawer.vue'
import Loader from '/imports/ui/vueComponents/helperComponents/Loader.vue'
import _ from 'lodash'

currentUser = -> Meteor.user()

export default
  computed:
    allSubscriptionsReady: ->
      !_.includes(this.$subReady, false)

    noLoginRedirect: ->
      unless @currentUserId
        @$router.push({name: 'Login'})
        false
      else
        true

  meteor:
    notificationObserverHandle: -> null

    currentOrganisationId: ->
      Meteor.user()?.currentOrganisationId()

    currentUserId: ->
      Meteor.userId()

    $subscribe:
      'loggedInUser': []
      'organisationRoles': -> [{organisationId: @currentOrganisationId}]
      'organisationStocks': -> [{organisationId: @currentOrganisationId}]
      'organisationUsers': -> [{organisationId: @currentOrganisationId}]
      'myOrganisation': -> [{organisationId: @currentOrganisationId}]

  methods:
    toggleDrawer: ->
      @.$refs.drawer.drawer = !@.$refs.drawer.drawer

    toggleNavigationDrawer: ->
      @.$refs.drawer.drawer = !@.$refs.drawer.drawer

  components:
    'loader': Loader
    'nav-bar': NavBar
    'navigation-drawer': NavigationDrawer
</script>

<style lang="stylus">
body
  .application
    height: 100vh
    .application--wrap
      height: 100%
      .authenticated-layout
        position: relative
        height: 100%
        main
          position: absolute
          top: 64px
          width: 100%
          height: calc(100% - 64px)
          overflow hidden
          .content--wrap
            height: 100%
            .content-container
              padding: unset
              height: 100%
              .scroll-container
                padding: 16px
                max-height: 100%
                overflow-y: scroll
                overflow-x: hidden
                -webkit-overflow-scrolling: touch
              .main-panel-with-header
                height: 100%
                .scroll-container
                  max-height: calc(100% - 45px)
    //  TODO: to be moved into the navbar vue, cannot find the value of main variable
    .nav-bar
      nav.top-nav
        .toolbar__content
          border-bottom main solid 5px
@media only screen and (max-width : 992px)
  .application.theme--light
    .nav-bar
      nav.top-nav
        .toolbar__content
          border-bottom main solid 3px
</style>
