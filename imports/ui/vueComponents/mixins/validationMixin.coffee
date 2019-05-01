import _ from 'lodash'

ValidationMixin =
  data: ->
    document: {}
    clearFormAfterSubmit: true
    documentId: null
    methodType: 'insert' #accepts 2 values [insert, update]
    successCallback: ((success)-> console.log('Saved successfully'))
    errorCallback: ((error)-> console.log('Error while saving'))

  watch:
    initialDocument: ->
      @initializeData()

  methods:
    cleanDoc: ->
      @validationContext.clean(@document, {removeEmptyStrings: false})

    validate: (field) ->
      @validationContext.validate(@cleanDoc(), {keys: [field]})

    getErrorMessage: (field) ->
      if @validationContext.keyIsInvalid(field)
        @validationContext.keyErrorMessage(field)

    getFormParameters: ->
      if @methodType == 'update'
        {_id: @documentId, modifier: {$set: @cleanDoc()}}
      else
        @cleanDoc()

    submit: ->
      #had to clean the object as empty string was not rejected
      #in validation for a non optional string field
      if @validationContext.validate(@cleanDoc())
        Meteor.call(@method, @getFormParameters(), (error, success)=>
          @successCallback(success) if success? and 'function' is typeof @successCallback
          @errorCallback(error) if error? and 'function' is typeof @errorCallback
        )
        @clear() if @clearFormAfterSubmit

    clear: ->
      @document = Object.assign({}, @initialDocument)
      @validationContext.reset()
      @afterClearCallback() if @afterClearCallback

    initializeData: ->
      @document = Object.assign({}, @initialDocument)
      if @methodType == 'update'
        @documentId = @document._id
        @document = _.omit(@document, '_id')
        @clearFormAfterSubmit = false

  created: ->
    @initializeData()

export { ValidationMixin }
