import { RouterFactory } from 'meteor/akryum:vue-router2'
import Home from '/imports/ui/Home.vue'
import Organisations from '/imports/ui/Organisations.vue'
import About from '/imports/ui/About.vue'

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
    {
      path: '/about',
      name: 'about',
      component: About,
    },
  ])
)

export default routerFactory.create()
