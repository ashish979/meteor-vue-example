import { Meteor } from 'meteor/meteor'
import Vue from 'vue'
/* /client/client.js */
import { RouterFactory, nativeScrollBehavior } from 'meteor/akryum:vue-router2'

// Create router instance
const routerFactory = new RouterFactory({
  mode: 'history',
  scrollBehavior: nativeScrollBehavior,
})

// App layout
var AppLayout = require('/imports/ui/AppLayout.vue');

// App start
Meteor.startup(() => {
  // Create the router instance
  const router = routerFactory.create()

  // Start the Vue app
  new Vue({
    router,
    render: h => h(AppLayout),
  }).$mount('app');
});
