// Generated by CoffeeScript 1.4.0
(function() {
  var Collection, mixin, operators, sort,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  operators = {
    eq: function(l, r) {
      return l === r;
    },
    gt: function(l, r) {
      return l > r;
    },
    gte: function(l, r) {
      return l >= r;
    },
    lt: function(l, r) {
      return l < r;
    },
    lte: function(l, r) {
      return l <= r;
    },
    neq: function(l, r) {
      return l !== r;
    },
    match: function(l, r) {
      return r.test(l);
    },
    like: function(l, r) {
      l = l.toLowerCase();
      r = r.toLowerCase();
      return l.indexOf(r) > -1;
    },
    within: function(l, arr) {
      return __indexOf.call(arr, l) >= 0;
    },
    outside: function(l, arr) {
      return !(__indexOf.call(arr, l) >= 0);
    },
    between: function(l, arr) {
      var vl, vr;
      vl = arr[0];
      vr = arr[1] || vl;
      return l >= vl && l <= vr;
    }
  };

  sort = function(collection, options) {
    var limit, order, orderBy;
    if (!(options && options.orderBy)) {
      return collection;
    }
    orderBy = options.orderBy, order = options.order, limit = options.limit;
    collection = _.sortBy(collection, function(model) {
      return model[orderBy];
    });
    if (order && order.toLowerCase() === 'desc') {
      collection = collection.reverse();
    }
    if (limit) {
      collection = collection.slice(0, limit);
    }
    return collection;
  };

  mixin = {};

  _.each(operators, function(compare, method) {
    return mixin[method] = function(collection, conditions, orderOptions) {
      var res;
      res = _.filter(collection, function(item) {
        return _.all(conditions, function(val, key) {
          return compare(item[key], val);
        });
      });
      return sort(res, orderOptions);
    };
  });

  mixin.query = function(collection, options, orderOptions) {
    var res;
    res = _.filter(collection, function(model) {
      return _.all(options, function(conditions, method) {
        var compare;
        compare = operators[method];
        return _.all(conditions, function(val, key) {
          return compare(model[key], val);
        });
      });
    });
    return sort(res, orderOptions);
  };

  mixin.orderBy = function(collection, prop, options) {
    var criteria;
    criteria = {
      order: 'asc',
      orderBy: prop
    };
    criteria = _.extend(criteria, options);
    return sort(collection, criteria);
  };

  _.mixin(mixin);

  Collection = (function(_super) {
    var _this = this;

    __extends(Collection, _super);

    function Collection(models, options) {
      Collection.__super__.constructor.call(this, models, options);
    }

    _.each(operators, function(compare, method) {
      return Collection.prototype[method] = function(conditions, sortingOptions) {
        return _[method](this.toJSON(), conditions, sortingOptions);
      };
    });

    Collection.prototype.query = function(conditions, sortingOptions) {
      return _.query(this.toJSON(), conditions, sortingOptions);
    };

    Collection.prototype.orderBy = function(prop, options) {
      return _.orderBy(this.toJSON(), prop, options);
    };

    return Collection;

  }).call(this, Backbone.Collection);

  if (typeof require !== "undefined" && require !== null) {
    module.exports = Collection;
  } else {
    window.Collection = Collection;
  }

}).call(this);
