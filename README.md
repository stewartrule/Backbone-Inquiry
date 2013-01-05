# Backbone-Inquiry

A simple api to query your Backbone Collections. Also available as underscore/lodash mixins.


### Api

All methods accept 2 parameters. The first parameter contains a hash for comparison. The second (optional) parameter contains options for sorting.


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
* query()


## Examples


```coffeescript
users = new Collection data
```

### within
```coffeescript
pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }
```

### gt
```coffeescript
high = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }
```

### between
```coffeescript
kids = users.between age: [5, 12]
```

### match
```coffeescript
nameAlike = users.match name: /in/g
```

### byLength
```coffeescript
byLength = users.byLength name: 5
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
