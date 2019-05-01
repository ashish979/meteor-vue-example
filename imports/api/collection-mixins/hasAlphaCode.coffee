`import SimpleSchema from 'simpl-schema';`

{ Organisations } = require '/imports/api/organisations/collection.coffee'

schema = (collection)->
  new SimpleSchema
    codeNumber:
      type: Number
      autoValue: (doc)->
        if @isUpdate and @docId?
          currentDoc = collection.findOne({_id: @docId})
          # if the code is already set don't allow it to be overwritten on update
          if currentDoc?.codeNumber?
            @unset()
            return
          return if @field('codeNumber')? # leave it as is if it's been set as part of the update.
          organisationId = currentDoc?.organisationId
        else
          organisationId = @field('organisationId').value

        if organisationId?
          organisation = Organisations.findOne({_id: organisationId})
          toBeCodeNumber = organisation.nextCodeFor(collection.alphaCode)
          if (@isInsert || currentDoc)
            return toBeCodeNumber
          else if (this.isUpsert)
            # this basically means you can't use upsert to set the code via an update, i.e. use insert or plain update
            return {$setOnInsert: toBeCodeNumber}
        else
          this.unset()

helpers =
  alphaCode: ->
    "#{@collection().alphaCode}-#{@codeNumber}"

  #this method needs to be overridden if the fieldName to display is not name
  textToDisplay: (fieldName = 'name') ->
    @[fieldName] || ""

  truncatedTextToDisplay: (fieldName = 'name', length = 20) ->
    text = @textToDisplay()
    if text.length > length
      text.substring(0, length) + ' ...'
    else
      text

  truncatedDisplayName: ->
    @alphaCode() + " - " + @truncatedTextToDisplay()

  displayName: () ->
    @alphaCode() + " - " + @textToDisplay()

exports.HasAlphaCode =
  schema: schema
  helpers: helpers

