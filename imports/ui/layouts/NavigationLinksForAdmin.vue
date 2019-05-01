<template lang='pug'>
.organisation-admin-links
  v-list-tile(v-if='isOrganisationAdmin')
    v-list-tile-content.px-3.pt-2
      v-checkbox(label="Admin View" @change='toggleAdminView' v-model='adminViewCheck' :hide-details='true')
  .organisation-super-admin-links(v-if='canViewAdminSection')
    navigation-link-with-tooltip(
      :to="{name: 'Organisations.dashboard', params: {id: currentOrganisationId}}"
      icon='fa fa-dashboard'
      :title="currentOrganisationDashboardTitle"
    )
    navigation-link(:to="{name: 'OrganisationRoles.list'}" icon='fa fa-users' title="Roles")
    navigation-link(:to="{name: 'OrganisationUsers.list'}" icon='fa fa-user' title="Users")
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import { Session } from 'meteor/session'
import NavigationLink from '/imports/ui/vueComponents/helperComponents/NavigationLink.vue'
import NavigationLinkWithTooltip from '/imports/ui/vueComponents/helperComponents/NavigationLinkWithTooltip.vue'

export default
  computed:
    currentOrganisationUrl: -> "/organisations/#{@currentOrganisation?._id}"
    currentOrganisationDashboardTitle: -> "#{@currentOrganisation?.name} - Dashboard"
    currentOrganisationId: -> @currentOrganisation?._id

  meteor:
    learner: -> Meteor.user()
    currentOrganisation: -> @learner?.currentOrganisation()
    isSuperAdmin: -> @learner?.isSuperAdmin()
    isOrganisationAdmin: -> @learner?.isOrganisationAdmin()
    adminViewCheck: -> Session.get('adminView')
    adminView: -> Session.get('adminView')
    canViewAdminSection: -> @isSuperAdmin || (@isOrganisationAdmin && @adminView)
    canViewLearnerSection: -> (@isOrganisationAdmin && !@adminView)

  components:
    'navigation-link': NavigationLink
    'navigation-link-with-tooltip': NavigationLinkWithTooltip

  mounted: ->
    Session.set('adminView', true) if @adminView == undefined

  methods:
    toggleAdminView: ->
      adminView = Session.get('adminView')
      Session.set('adminView', !adminView)
      @goToAdminDashboard(!adminView)

    goToAdminDashboard: (adminView) ->
      unless adminView
        @$router.push({name: 'Learner.dashboard'})
      else
        @$router.push({name: 'Organisations.dashboard', params: {id: @currentOrganisation?._id}})
</script>
