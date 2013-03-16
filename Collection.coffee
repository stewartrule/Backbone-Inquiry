

# Comparison helpers
# These will define the api
operators =
    eq: (l, r) ->
        l is r

    gt: (l, r) ->
        l > r

    gte: (l, r) ->
        l >= r

    lt: (l, r) ->
        l < r

    lte: (l, r) ->
        l <= r

    not: (l, r) ->
        l isnt r

    match: (l, r) ->
        r.test l

    like: (l, r) ->
        l = l.toLowerCase()
        r = r.toLowerCase()
        l.indexOf(r) > -1

    within: (l, arr) ->
        l in arr

    outside: (l, arr) ->
        not (l in arr)

    between: (l, arr) ->
        vl = arr[0]
        vr = arr[1] or vl
        l >= vl && l <= vr


# Sort collection on different criteria
sort = (collection, options) ->
    unless options and options.orderBy
        return collection
    {orderBy, order, limit} = options
    collection = _.sortBy collection, (model) ->
        model[orderBy]
    if order and order.toLowerCase() is 'desc'
        collection = collection.reverse()
    if limit
        collection = collection.slice(0, limit)
    collection


# Tmp object to store mixins
mixin = {}

# Use operator partials to generate query methods on _
# with the same names as the operator method names
_.each operators, (compare, method) ->
    mixin[method] = (collection, conditions, orderOptions) ->
        res = _.filter collection, (item) ->
            _.all conditions, (val, key) ->
                compare item[key], val
        sort res, orderOptions


# The method to combine different type of conditions into one command
mixin.query = (collection, options, orderOptions) ->
    res = _.filter collection, (model) ->
        _.all options, (conditions, method) ->
            compare = operators[method]
            _.all conditions, (val, key) ->
                compare model[key], val
    sort res, orderOptions

# Simple way to sort a collection based on a property value
mixin.orderBy = (collection, prop, options) ->
    criteria = { order: 'asc', orderBy: prop }
    criteria = _.extend criteria, options
    sort collection, criteria

# Assign mixin to underscore or lodash
_.mixin mixin


# Add methods to Backbone.Collection
class Collection extends Backbone.Collection

    # Copy comparison query mixins to the prototype
    _.each operators, (compare, method) =>
        @prototype[method] = (conditions, sortingOptions) ->
            _[method] @toJSON(), conditions, sortingOptions

    # Delegate to _.query
    query: (conditions, sortingOptions) ->
        _.query @toJSON(), conditions, sortingOptions

    orderBy: (prop, options) ->
        _.orderBy @toJSON(), prop, options



# Export
if require?
    module.exports = Collection
else
    window.Collection = Collection