<template lang='pug'>
v-card.pa-3.my-2(:hover='true' @mouseout='hideFullTextContainer' @mouseover='showFullTextContainer')
  v-layout(row wrap)
    v-flex(xs10 v-if="$slots['hover-actions']")
      div.truncated-text-container {{ truncatedText }}
    v-flex(xs12 v-else)
      div.truncated-text-container {{ truncatedText }}
    v-flex(xs2)
      slot(name='hover-actions')
</template>

<script lang='coffee'>
export default
  props: ['truncatedText']

  data: ->
    fullTextContainerVisible: false

  methods:
    showFullTextContainer: ->
      @fullTextContainerVisible = true
    hideFullTextContainer: ->
      @fullTextContainerVisible = false
</script>
