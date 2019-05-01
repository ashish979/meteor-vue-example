<template lang='pug'>
v-app
  unauthenticated-layout(v-if="isUnauthenticated")
  authenticated-layout(v-else)
</template>

<script lang='coffee'>
import AuthenticatedLayout from './AuthenticatedLayout.vue'
import UnAuthenticatedLayout from './UnAuthenticatedLayout.vue'

export default
  computed:
    routeLayout: -> @$route.meta.layout
    isUnauthenticated: -> @routeLayout == 'unauthenticated'

  components:
    'unauthenticated-layout': UnAuthenticatedLayout
    'authenticated-layout': AuthenticatedLayout
</script>

<style lang="stylus">
$body-font-family = 'CenturyGothic'
@import '~node_modules/vuetify/src/stylus/main'
@import '~imports/ui/colour-theme.styl'

*
  overflow: hidden

.overflow-visible
  overflow: visible

html
  min-height: 100%
  -webkit-text-size-adjust: none

body
  height: 100%;
  position: absolute;
  width: 100%;
  .application
    a
      text-decoration: none
      .unclickable
        cursor: none

@media (hover:none), (hover:on-demand)
  .card--hover
    transition: unset !important
    &:hover
      -webkit-box-shadow: 0px 2px 1px -1px rgba(0,0,0,0.2), 0px 1px 1px 0px rgba(0,0,0,0.14), 0px 1px 3px 0px rgba(0,0,0,0.12) !important
      box-shadow: 0px 2px 1px -1px rgba(0,0,0,0.2), 0px 1px 1px 0px rgba(0,0,0,0.14), 0px 1px 3px 0px rgba(0,0,0,0.12) !important
</style>
