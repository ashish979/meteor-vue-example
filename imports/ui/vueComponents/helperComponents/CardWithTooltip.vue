<template lang='pug'>
.text-container.overflow-visible(:data-objectid='objectId')
  v-card(class='full-text-container pa-2' v-show='fullTextContainerVisible')
    | {{ fullText }}
  router-link.overflow-visible(:to='to' :tag='truncatedTextContainerTag')
    v-card.truncated-text-card.pa-3.my-2(:class='selectedClass' @mouseout='hideFullTextContainer' @mouseover='showFullTextContainer' :hover='true')
      v-layout(row wrap)
        v-flex(xs10 v-if="hoverActionsSlot")
          div.truncated-text-container {{ truncatedText }}
        v-flex(xs12 v-else)
          div.truncated-text-container {{ truncatedText }}
        v-flex(xs2)
          slot(name='hover-actions' :fullTextContainerVisible="fullTextContainerVisible")
</template>

<script lang='coffee'>
export default
  props:
    fullText: String
    truncatedText: String
    href: String
    to:
      type: Object
      default: -> {}
    objectId: String
    selected: Boolean
      type: Boolean
      default: false

  data: ->
    fullTextContainerVisible: false

  computed:
    selectedClass: -> if @selected then 'selected' else ''
    truncatedTextContainerTag: -> if Object.keys(@to).length == 0 then 'div' else 'a'
    hoverActionsSlot: -> @$scopedSlots['hover-actions']

  methods:
    showFullTextContainer: ->
      @fullTextContainerVisible = true
    hideFullTextContainer: ->
      @fullTextContainerVisible = false
</script>

<style lang='stylus' scoped>
.text-container
  position: relative

.full-text-container
  position: absolute
  bottom: 4.3rem
  z-index: 1000

a
  text-decoration: none;

.truncated-text-container
  white-space: nowrap
  overflow: hidden
  text-overflow: ellipsis

.selected
  background-color: #e8fbd5 !important
</style>
