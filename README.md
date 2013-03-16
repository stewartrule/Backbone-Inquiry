# Backbone-Inquiry

A very lightweight (1.8 Kb minified, 769 bytes gzipped) utility to query your Backbone Collections.

All new methods are also available as mixins to Lo-Dash or underscore.js.

All query methods accept 2 parameters. The first parameter contains a hash for comparison. The second (optional) parameter contains options for sorting.

### Api

#### single operator
* eq()
* gt()
* gte()
* lt()
* lte()
* not()
* match()
* like()
* within()
* between()
* outside()

#### multi operator
* query()

#### ordering
* orderBy()


## Examples


```coffeescript
# Extend from Collection instead of Backbone.Collectiom
class Users extends Collection
    model: User
    # etc..

users = new Users foo
```

## Single operator

### gt

Get all users with a highscore greater then 1000.

```coffeescript
highscore = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }
```


### between

Get all users between the age of 5 and 12.

```coffeescript
kids = users.between age: [5, 12]
```

### within

Get all users who play hard and impossible modes.

```coffeescript
pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }
```

### outside

Get all users who don't play hard and impossible modes.

```coffeescript
easy = users.outside { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', limit: 5 }
```

You can also use all methods with lodash or underscore.js

```coffeescript
# eq is basically the same as where
male = users.eq male: yes

easy = _.outside male, { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', limit: 5 }
```

### match

Get all users who have at least 2 L's in their name

```coffeescript
nameAlike = users.match name: /l{2,}/g
```


### like

Get all users whose names contain 'in' (case insensitive)

```coffeescript
nameAlike = users.like name: 'in'
```



## Multi operator

### query
Query is a combination filter of all the methods above.

#### syntax

```coffeescript
collection.query {
    operator1:
        key: value
        key: value

    operator2:
        key: value
        key: value
}
```

#### examples
```coffeescript

fastGrannies = users.query { gt: { age: 70 }, eq: { male: no }, lt: { duration: 100 } }

noobs = users.query {
    eq: { difficulty: 'noob' },
    lt: { highscore: 600 }
}, {
    orderBy: 'name',
    order: 'desc'
}
```


## Ordering
All methods accept an optional parameter for sorting.

Current options are: 'orderBy', 'order' and 'limit'

You can also call orderBy as a method. The first parameter is the propertyname. The second (optional) parameter can contain all of the options above.

### orderBy
```coffeescript
alfa = users.orderBy 'name', { limit: 5, order: 'desc' }
```

## Demo
First run `npm install` so Backbone and Lo-Dash are in place.


