<template lang="pug">
v-layout(row wrap align-center justify-center)
  v-flex(xs10 sm8 md6 class='overflow-visible')
    v-card.pa-3(v-if='!signingIn')
      h2 Sign In with Office 365
      v-form(ref="activeDirectorySignInForm" v-model="valid")
        .error-message.pa-2.my-1(v-if="error")  {{error}}
        v-text-field(
          label='Email'
          v-model='document.email'
          type="email"
          :rules="[rules.required, rules.email]"
          required
          validate-on-blur
        )
        v-layout(flex wrap row align-center justify-left)
          v-flex(xs12 sm12 md12)
            v-btn.ml-0(@click="submit" :ripple='false') Sign In
            v-btn(:to={name: 'Login'} :ripple='false') Back
    v-layout(v-else flex wrap row align-center justify-center)
      loader
</template>

<script lang="coffee">
import { Meteor } from 'meteor/meteor'
import SimpleSchema from 'simpl-schema'
import { login } from '/imports/ui/helpers/activeDirectoryLoginHelper.coffee'
import Loader from '/imports/ui/vueComponents/helperComponents/Loader.vue'

export default
  mounted: ->
    @signingIn = false
  data: ->
    signingIn: false
    error: null
    valid: true
    document: { email: '' }
    rules: {
      required: (value) => !!value || 'Required.',
      email: (value) =>
        pattern = SimpleSchema.RegEx.Email
        pattern.test(value) || 'Invalid e-mail.'
    }
  methods:
    submit: (event) ->
      event.preventDefault()
      if @$refs.activeDirectorySignInForm.validate()
        @signingIn = true
        Meteor.call('activeDirectory.getOAuthUrl', { email: @document.email, redirectPath: 'redirect' }, (error, result) =>
          if error or result.error
            @$notify({group: 'alert', data: { classArray: ['notification-error'] }, text: (error && error.reason) or result.error })
            @signingIn = false
          else
            if Meteor.isCordova
              login.call(@, result.url, @document.email, result.aDId)
            else
              localStorage.activeDirectoryUserEmail = @document.email
              localStorage.activeDirectoryId = result.aDId
              window.location = result.url
        )
  components:
    'loader': Loader

</script>

<style lang="stylus" scoped>

</style>