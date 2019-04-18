<template lang="pug">
  div(class="app-layout")
    app-menu
    router-view
</template>

<script lang="coffee">
import AppMenu from '/imports/ui/AppMenu.vue';

export default
  components:
    'app-menu': AppMenu
</script>
