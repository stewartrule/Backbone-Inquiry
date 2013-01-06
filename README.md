# Backbone-Inquiry

A very lightweight (1.8 Kb minified) api to query your Backbone Collections. Also available as underscore/lodash mixins.


All methods accept 2 parameters. The first parameter contains a hash for comparison. The second (optional) parameter contains options for sorting.

### Api

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
* orderBy()
* query()


## Examples


```coffeescript
users = new Collection data
```

## Single operator methods

### gt

get all users with a highscore greater then 1000

```coffeescript
highscore = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }
```


### between

get all users between the age of 5 and 12

```coffeescript
kids = users.between age: [5, 12]
```

### within

get all users that play hard and impossible modes

```coffeescript
pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }
```

### outside

get all users that don't play hard and impossible modes

```coffeescript
easygamers = users.outside { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', order: 'desc', limit: 5 }
```

### match

get all user user who's name name matches 'in'

```coffeescript
nameAlike = users.match name: /in/g
```

### byLength

get all users that have exactly 5 characters in their name

```coffeescript
fiveLetterNames = users.byLength name: 5
```


## query
Query is a combination of all the methods above.

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

### query
```coffeescript
noobish = users.query {
    eq:
        difficulty: 'noob'
    lt:
        highscore: 500
}, {
    orderBy: 'name'
    order: 'desc'
}
```

### orderBy
```coffeescript
alfa = users.orderBy 'name', { limit: 5 }
```