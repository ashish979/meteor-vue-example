<template lang='pug'>
form
  v-text-field(
    label='Name'
    v-model='document.name'
    @input="validate('name')"
    :error-messages="getErrorMessage('name')"
    required
  )
  v-btn(@click.prevent='submit' type="submit" :ripple='false') create
  v-btn(@click="clear" :ripple='false') clear
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import SimpleSchema from 'simpl-schema'
import { Organisations } from '/imports/api/organisations/collection.coffee'
import { ValidationMixin } from '/imports/ui/vueComponents/mixins/validationMixin.coffee'

export default
  mixins: [ValidationMixin]
  data: ->
    document: {}
    initialDocument: {}
    validationContext: Organisations.schema.pick('name').newContext()
    method: 'organisations.insert'
</script>
