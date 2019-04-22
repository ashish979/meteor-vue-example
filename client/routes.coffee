import { RouterFactory } from 'meteor/akryum:vue-router2'
import Home from '/imports/ui/Home.vue'
import Organisations from '/imports/ui/Organisations.vue'
import { nativeScrollBehavior } from 'meteor/akryum:vue-router2'

routerFactory = new RouterFactory
  mode: 'history',
  scrollBehavior: nativeScrollBehavior

RouterFactory.configure((factory) ->
  factory.addRoutes([
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/organisations',
      name: 'organisations',
      component: Organisations,
    },

  ])
)

export default routerFactory.create()
