# README

# underscore/lodash Api

* _.eq(collection, conditions, sortingOptions)
* _.gt(collection, conditions, sortingOptions)
* _.gte(collection, conditions, sortingOptions)
* _.lt(collection, conditions, sortingOptions)
* _.lte(collection, conditions, sortingOptions)
* _.not(collection, conditions, sortingOptions)
* _.match(collection, conditions, sortingOptions)
* _.byLength(collection, conditions, sortingOptions)
* _.within(collection, conditions, sortingOptions)
* _.between(collection, conditions, sortingOptions)
* _.query(collection, conditions, sortingOptions)


# Backbone Api

* @eq(conditions, sortingOptions)
* @gt(conditions, sortingOptions)
* @gte(conditions, sortingOptions)
* @lt(conditions, sortingOptions)
* @lte(conditions, sortingOptions)
* @not(conditions, sortingOptions)
* @match(conditions, sortingOptions)
* @byLength(conditions, sortingOptions)
* @within(conditions, sortingOptions)
* @between(conditions, sortingOptions)
* @query(conditions, sortingOptions)


# Examples


```coffeescript

users = new Collection foo

# Pros
pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }


# Scores higher then 1000
high = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }


# All kids between the age of 5 and 12
kids = users.between age: [5, 12]


```