# Backbone-Inquiry

A very lightweight (1.8 Kb minified, 769 bytes gzipped) api to query your Backbone Collections. Also available as underscore/lodash mixins.

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
* byLength()
* within()
* between()
* outside()

#### multi operator
* query()

#### ordering
* orderBy()


## Examples


```coffeescript
users = new Collection data
```

## Single operator

### gt

get all users with a highscore greater then 1000

```coffeescript
highscore = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }
```


### between

Get all users between the age of 5 and 12

```coffeescript
kids = users.between age: [5, 12]
```

### within

Get all users that play hard and impossible modes

```coffeescript
pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }
```

### outside

Get all users that don't play hard and impossible modes

```coffeescript
easy = users.outside { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', limit: 5 }
```

you can also use all methods with lodash or underscore

```coffeescript
# eq comes down to beeing the same as where
male = users.eq male: yes

easy = _.outside male, { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', limit: 5 }
```

### match

Get all user user who's name matches 'in'

```coffeescript
nameAlike = users.match name: /in/g
```

### byLength

Get all users that have exactly 5 characters in their name

```coffeescript
fiveLetterNames = users.byLength name: 5
```


## Multi operator

### query
Query is a combination filter of all the methods above.

##### syntax

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

you can also call orderBy as a method. The first param is the propertyname. The second (optional) parameter can contain all of the options above.

### orderBy
```coffeescript
alfa = users.orderBy 'name', { limit: 5, order: 'desc' }
```

