import { RouterFactory, nativeScrollBehavior } from 'meteor/akryum:vue-router2'

# Components

import StocksList from '/imports/ui/vueComponents/stock/StocksList.vue'
import OrganisationsList from '/imports/ui/vueComponents/organisation/OrganisationsList.vue'
import OrganisationDashboard from '/imports/ui/vueComponents/organisation/OrganisationDashboard.vue'
import OrganisationUsersList from '/imports/ui/vueComponents/organisationUser/OrganisationUsersList.vue'
import OrganisationRolesList from '/imports/ui/vueComponents/organisationRole/OrganisationRolesList.vue'
import Login from '/imports/ui/vueComponents/login/Login.vue'
import Welcome from '/imports/ui/vueComponents/Welcome.vue'
import NotFound from '/imports/ui/vueComponents/staticPages/NotFound.vue'

routerFactory = new RouterFactory
  mode: 'history',
  scrollBehavior: nativeScrollBehavior

withPrefix = (prefix, routes) ->
  routes.map((route) ->
    route.path = prefix + route.path
    route
  )

addUnauthenticatedMeta = (routes) ->
  routes.map((route) ->
    route.meta = Object.assign({},route.meta, {
      layout: 'unauthenticated'
    })
    route
  )

unauthenticatedRoutes = [
  {
    path: '/signIn'
    name: 'Login'
    component: Login
  }
]

RouterFactory.configure(((router) ->
  router.addRoutes([
    {
      path: '/'
      name: 'App.Home'
      component: Welcome
    }
    {
      path: '/organisations'
      name: 'Organisations.list'
      component: OrganisationsList
    }
    {
      path: '/organisationDashboard/:id'
      name: 'Organisations.dashboard'
      component: OrganisationDashboard
    }
    {
      path: '/stocks'
      name: 'Stocks.list'
      component: StocksList
    }
    {
      path: '/organisationUsers'
      name: 'OrganisationUsers.list'
      component: OrganisationUsersList
    }
    {
      path: '/organisationRoles'
      name: 'OrganisationRoles.list'
      component: OrganisationRolesList
    }
    {
      path: '*',
      name: 'NotFound'
      component: NotFound
    }, addUnauthenticatedMeta(unauthenticatedRoutes)...
  ])
), -1)

export default routerFactory.create()
