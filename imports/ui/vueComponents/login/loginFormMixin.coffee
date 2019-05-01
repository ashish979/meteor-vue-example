import SimpleSchema from 'simpl-schema'

LoginFormMixin=
  data: ->
    document: { email: '', password: '' }
    rules: {
      required: (value) => !!value || 'Required.',
      email: (value) =>
        pattern = SimpleSchema.RegEx.Email
        pattern.test(value) || 'Invalid e-mail.'
      passwordLength: (value) =>
        value.length >= 6 || 'Password length should be minimum 6 characters'
      matchConfirmPasword: (value)=>
        value == @document.password || 'Passwords do not match'
    }
  methods:
    submit: (event)->
      event.preventDefault()
      if @$refs.signInForm.validate()
        Meteor.loginWithPassword({email: @document.email}, @document.password, (error)=>
          if error?
            @formatError(error)
          else 
            @$router.go(-1)
        )
    formatError: (error)->
      [..., last] = error.message.split(" ")
      errorCodePattern = /^\[([\w.-]+)\]$/
      if last.match errorCodePattern
        @error = error.message.split(" ").slice(0,-1).join(" ")
      else
        @error = error.message

export { LoginFormMixin }
