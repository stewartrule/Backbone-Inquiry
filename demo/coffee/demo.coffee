
el = (tag) ->
    tag or= 'div'
    $ document.createElement tag


$ ->

    $target = $('#demo')

    # Helpers to quickly generate simple tables
    makeRow = (data, tag) ->
        $row = el('tr')
        _.each (data), (val, key) ->
            $cell = el(tag).text(val).appendTo($row)
        $row

    addTable = (data, codesample = '') ->
        $table = el('table')

        # Column headers
        columns = _.keys(data[0])
        $table.append makeRow columns, 'th'

        # Spreadsheet data
        for row in data
            $table.append makeRow row, 'td'

        $code = el('code').text codesample
        $pre = el('pre').append $code
        $target.append $pre
        $target.append $table


    # Calculate highscores
    data = _.map data, (row) ->
        row.highscore = _.max row.scores
        delete row.scores
        row


    users = new Collection data


    # Regex matching
    nameAlike = users.match name: /in/g
    addTable nameAlike, "users.match name: /in/g"


    # Search by string length
    byLength = users.byLength name: 5
    addTable byLength, "users.byLength name: 5"


    # Pros
    pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }
    addTable pros, "users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }"


    # Scores higher then 1000
    high = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }
    addTable high, "high = users.gt highscore: 1000"


    # All kids between the age of 5 and 12
    kids = users.between age: [5, 12]
    addTable kids, "users.between age: [5, 12]"


    # Query with multiple comparisons
    noobish = users.query { eq: { difficulty: 'noob' }, lt: { highscore: 500 } }
    addTable noobish, "users.query { eq: { difficulty: 'noob' }, lt: { highscore: 500 } }"


    # And another one with multiple comparisons
    mixed = users.query {
        gte:
            highscore: 150
        gt:
            duration: 200
        between:
            age: [5, 35]
        eq:
            male: yes
    }

    addTable mixed, """
    users.query {
        gte:
            highscore: 150
        gt:
            duration: 200
        between:
            age: [5, 35]
        eq:
            male: yes
    }
    """


