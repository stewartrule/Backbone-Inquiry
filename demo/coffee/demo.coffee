
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


    # orderBy
    ordered = users.orderBy 'name', { limit: 5 }
    addTable ordered, "users.orderBy 'name', { limit: 5 }'"

    # Regex matching
    matched = users.match name: /l{2,}/g
    addTable matched, "users.match name: /l{2,}/g"

    # Case insensitive search
    nameAlike = users.like name: 'in'
    addTable nameAlike, "users.like name: 'in'"

    # Pros
    pros = users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }
    addTable pros, "users.within { difficulty: ['hard', 'impossible'] }, { orderBy: 'age', order: 'asc', limit: 5 }"

    # Easy gamers
    easy = users.outside { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', order: 'desc', limit: 5 }
    addTable easy, "users.outside { difficulty: ['hard', 'impossible'] }, { orderBy: 'highscore', order: 'desc', limit: 5 }"

    # Scores higher then 1000
    high = users.gt { highscore: 1000 }, { orderBy: 'highscore', order: 'desc' }
    addTable high, "high = users.gt highscore: 1000"

    # All kids between the age of 5 and 12
    kids = users.between age: [5, 12]
    addTable kids, "users.between age: [5, 12]"

    # Query with multiple comparisons
    noobish = users.query { eq: { difficulty: 'noob' }, lt: { highscore: 600 } }, { orderBy: 'name', order: 'desc' }
    addTable noobish, "users.query { eq: { difficulty: 'noob' }, lt: { highscore: 600 } }, { orderBy: 'name', order: 'desc' }"

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


