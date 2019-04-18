<template>
  <div class="app-menu">
    <router-link :to="{ name:'home', exact: true }">Home</router-link>
    <router-link :to="{ name:'organisations' }">Organisations</router-link>
    <router-link :to="{ name:'about' }">About</router-link>
  </div>
</template>

<style scoped lang="sass">

  .app-menu
    margin: 32px 0
    text-align: center

    a
      display: inline-block
      padding: 6px
      margin: 0 6px
      border-radius: 3px
      &.v-link-active
        background: #dadada
        color: white
</style>
