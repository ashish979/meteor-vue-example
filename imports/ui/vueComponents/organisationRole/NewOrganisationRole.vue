<template lang='pug'>
form
  v-text-field(
    label='Name'
    v-model='document.name'
    @input="validate('name')"
    :error-messages="getErrorMessage('name')"
    required
  )
  v-btn.ml-0(@click.prevent='submit' type="submit" :ripple='false') create
  v-btn(@click="clear" :ripple='false') clear
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import SimpleSchema from 'simpl-schema'

# components
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'

#mixins
import { ValidationMixin } from '/imports/ui/vueComponents/mixins/validationMixin.coffee'

schemaContext = ->
  schema = OrganisationRoles.schema.pick('name')
  schema.newContext()

export default
  mixins: [ValidationMixin]

  data: ->
    document: {}
    initialDocument: {}
    validationContext: schemaContext()
    method: 'organisationRoles.insert'
</script>


