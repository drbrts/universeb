express = require 'express'
app = express()

args =
  schemas: [
    '../openspeeddating/src/models/user'
    '../openspeeddating/src/models/meetup'
  ]

UniverseB = require('./UniverseB') app, args

app.use UniverseB

app.listen 3000
console.log 'Listening on port 3000'

