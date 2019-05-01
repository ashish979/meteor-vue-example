<template lang='pug'>
card-with-tooltip(:full-text = 'stock.textToDisplay()' :truncatedText = 'stock.displayName()')
</template>

<script lang='coffee'>
import CardWithTooltip from '/imports/ui/vueComponents/helperComponents/CardWithTooltip.vue'

export default
  props: ['stock']

  components:
    'card-with-tooltip': CardWithTooltip
</script>
