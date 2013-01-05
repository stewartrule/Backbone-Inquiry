# README

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
high = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }


### between
kids = users.between age: [5, 12]


```