
# Condition partials
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

    byLength: (l, r) ->
        l.length is r

    within: (l, arr) ->
        l in arr

    between: (l, arr) ->
        vl = arr[0]
        vr = arr[1] or vl
        l >= vl && l <= vr


sort = (collection, conditions) ->
    unless conditions and conditions.orderBy
        return collection
    {orderBy, order, limit} = conditions
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
    mixin[method] = (collection, conditions, sortingOptions) ->
        res = _.filter collection, (item) ->
            _.all conditions, (val, key) ->
                compare item[key], val
        sort res, sortingOptions


# One single method to combine different type of conditions into one command
mixin.query = (collection, options, sortingOptions) ->
    res = _.filter collection, (model) ->
        _.all options, (conditions, method) ->
            compare = operators[method]
            _.all conditions, (val, key) ->
                compare model[key], val
    sort res, sortingOptions

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


# Export
if require?
    module.exports = Collection
else
    window.Collection = Collection