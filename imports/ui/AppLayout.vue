<template lang="pug">
div.app-layout
  app-menu
  router-view
</template>

<script lang="coffee">
import AppMenu from './AppMenu.vue'

export default
  components:
    'app-menu': AppMenu
</script>
