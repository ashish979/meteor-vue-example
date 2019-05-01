<template lang='pug'>
v-list-tile(:to='to' active-class='primary--text active')
  v-btn(icon :ripple='false')
    v-icon(:small='true') {{ icon }}
  v-list-tile-content
      v-list-tile-title {{ title }}
</template>

<script lang='coffee'>

export default
  props: ['to', 'title', 'icon']
</script>
