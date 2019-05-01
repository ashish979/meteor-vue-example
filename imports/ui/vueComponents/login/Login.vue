<template lang="pug">
v-layout(row wrap align-center justify-center)
  v-flex(xs10 sm8 md6 class='overflow-visible')
    v-card.pa-3
        h2 Sign In
        v-form(ref="signInForm")
          .error-message.pa-2.my-1(v-if="error")  {{error}}
          v-text-field(
            label='Email'
            v-model='document.email'
            type="email"
            :rules="[rules.required, rules.email]"
            required
            validate-on-blur
          )
          v-text-field(
            label='Password'
            v-model='document.password'
            required
            type="password"
            :rules="[rules.required]"
            validate-on-blur
          )
          v-layout(flex wrap row align-center justify-left)
            v-flex(xs5 sm4 md3)
              v-btn.ml-0(type="submit" @click.prevent="submit" :ripple='false') Sign In
</template>

<script lang="coffee">
import { Meteor } from 'meteor/meteor'
import { Accounts } from 'meteor/accounts-base'
import { LoginFormMixin } from './loginFormMixin.coffee'

export default
  mixins: [LoginFormMixin]

  data: ->
    error: null
    document: { email: '', password: '' }
</script>
<style lang="stylus" scoped>
.error-message
  background-color #E74C3C
  color white

.btn-container
  display: flex
  justify-content center
  .login-with-ad
    display flex
    justify-content center
    font-size 16px
    font-weight bold
    padding 10px
    width 250px
    height 45px
    color #fff !important
    border-color #0067b8 !important
    background-color #0067b8 !important
    &:hover
      background-color #005da6 !important

</style>

