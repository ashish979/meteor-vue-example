import { Meteor } from 'meteor/meteor'
import Vue from 'vue'
import VueMeteorTracker from 'vue-meteor-tracker'
Vue.use(VueMeteorTracker)

import './main.html'

import AppLayout from '/imports/ui/AppLayout.vue'
import router from './routes.coffee'

Meteor.startup =>
  new Vue(
    router: router,
    render: (h) -> h(AppLayout)
  ).$mount('app');

