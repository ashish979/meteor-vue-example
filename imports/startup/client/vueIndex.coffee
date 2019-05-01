import { Meteor } from 'meteor/meteor'
import '../simpleSchema.coffee'
import '/imports/api/allMethods.coffee'

import Vue from 'vue'
import router from './vueRouter.coffee'
import VueMeteorTracker from 'vue-meteor-tracker'
Vue.use(VueMeteorTracker)

import Vuetify from 'vuetify'

Vue.use(Vuetify,
  theme:
    primary: '#884cf6'
    secondary: '#70c914'
    success: '#00aa00'
)


Vue.mixin(
  data: ->
    isCordovaApp: Meteor.isCordova
)

# App layout
import VueLayout from '/imports/ui/layouts/VueLayout.vue'

Meteor.startup =>
  #h stands for hyperscript which itself stands for script that generates HTML structures
  new Vue(
    router: router
    render: (h) -> h(VueLayout)
  ).$mount('app')

  router.afterEach((to, from) =>
    console.log("Rendering " + to.name)
  )

