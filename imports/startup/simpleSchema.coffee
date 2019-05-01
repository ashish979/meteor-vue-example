import SimpleSchema from 'simpl-schema'

SimpleSchema.setDefaultMessages(
  "regEx mobilePhoneNumber": [
    {msg: "Must be a valid Australian mobile number with or without country code."}
    {exp: /(\+61|61|0)\d{9}/, msg: "Must be a valid Australian mobile number with or without country code."}
  ]
  messages:
    en:
      "mobilePhoneNumberRequired": "Mobile phone number required to set mobile notifications preference."
)
