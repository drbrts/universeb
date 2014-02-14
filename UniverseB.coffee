path = require 'path'
util = require 'util'
_ = require 'lodash'

class UniverseA
  constructor: (@app, @args = {}) ->
    console.log 'Initalizing Universe B'

    @models = {}

    # Default options
    @options =
      root: '/universeb'
      schemas: {}

    # Merge overrides
    _.merge @options, @args

    # Set up all the models
    @registerModels()

    # Set up routes
    @setupRoutes()

  registerModels: ->
    for schema in @options.schemas
      name = path.basename schema
      @models[name] = require(schema)

  setupRoutes: -> # Routes
    @app.get "#{@options.root}", @index
    @app.get "#{@options.root}/:model", @model
    @app.get "#{@options.root}/:model/:path", @path

  getModel: (model) -> @models[model]
  getSchema: (model) -> @models[model].schema

  index: (req, res, next) => # Index
    res.send util.inspect @models, {depth: 0}

  model: (req, res, next) =>
    {model} = req.params
    schema = @getSchema(model)
    res.send util.inspect schema.paths, {depth: 0}

  path: (req, res, next) =>
    {model, path} = req.params
    schema = @getSchema(model)
    res.send util.inspect schema.paths[path], {depth: 0}

  edit: (req, res, next) =>
    {model, path} = req.params

module.exports = (app, args) -> new UniverseA app, args
