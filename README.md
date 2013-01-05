# Backbone-Inquiry

A simple api to query your Backbone Collections. Also available as underscore/lodash mixins.


## Api

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
