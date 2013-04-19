$(document).ready(function() {
  
  var navMenuBar = $('#nav-menu'), formSearchBar = $('#form-search'), accountField = $('#main-search-bar');
  /* AccountSearchBar Animation */
  accountField.on('focus', function() {
    corm.AccountFieldIsFocused = true;
    formSearchBar.addClass('focus');
    navMenuBar.addClass('focus');
  });
  accountField.on('blur', function() {
    setTimeout(function() {
      formSearchBar.removeClass('focus');
      navMenuBar.removeClass('focus');
    }, 100);
    
  });
  
  var typeAheadInfo = {};
    
  /* Search account bar - Modify render function */
  $.fn.typeahead.Constructor.prototype.render = function(info, items) {
     var that = this;
     types = {};
     if (!info.by) {
      info.by = 'id';
     }
     items = $(items).map(function (i, item) {
       if (item.type == 'info') { return; }
       if (item.type && !types[item.type])  { types[item.type] = 0; }     
       if (types[item.type] < 5) {
        if (info.as) {
          switch (info.as) {
            case 'url':
              i = $(that.options.item).attr('data-value', info[item.type + '_url'].replace('[:id]', item[info.by])); break;
            default:
              i = $(that.options.item).attr('data-value', item[info.by]);
          }
        } else {
          i = $(that.options.item).attr('data-value', item[info.by]);
        }
         
         i.find('a').html(that.highlighter(item.name));
         types[item.type]++;
         return i[0];
       }
     });
     items.first().addClass('active');
     this.$menu.html(items);
     return this;
  };
  /* Search account bar - Modify process function */
  $.fn.typeahead.Constructor.prototype.process = function(items) {
      var that = this;
      item_info = items[0];
      items = $.grep(items, function (item) {
        return that.matcher(item.name||'');
      });
      items = this.sorter(items);
      if (!items.length) {
        return this.shown ? this.hide() : this;
      }
      
      return this.render(item_info, items.slice(0, this.options.items)).show();
  };
  /* Search account bar - Modify sorter function */ 
  $.fn.typeahead.Constructor.prototype.sorter = function(items) {
    var o = new Object();
    for(var i = 0; i < items.length; i++) {
      if (items[i].type && !o[items[i].type] && items[i].type != 'info') { o[items[i].type] = new Array(); }
      if (o[items[i].type])
          o[items[i].type].push(items[i]);
    }
    var beginswith = []
    , caseSensitive = []
    , caseInsensitive = []
    , item;
    for(var type in o) {
      for (var index in o[type]) {
        item = o[type][index];
        if (!item.name.toLowerCase().indexOf(this.query.toLowerCase())) beginswith.push(item)
            else if (~item.name.indexOf(this.query)) caseSensitive.push(item)
            else caseInsensitive.push(item)
      }
    }
    return beginswith.concat(caseSensitive, caseInsensitive) 
  };
  
  var tolerance = 0;
  
  /*
   * Main Search Bar
   * GET *.html
   */
  $('#main-search-bar').typeahead({
    source: function(typeahead, query) {
      if (typeahead.trim().length <= tolerance) {
        return false;
      }
      $.ajax({
          url: '/compte/search.json?contacts=true&account=' + typeahead,
          type: 'GET',
          dataType: 'json',
          success: function(o) {
            o[0].as = 'url'; o[0].by = 'id';
            corm_var['task-account-search-typeahead'] = o.slice(0);
            query(o);
          }
      });
    },
    updater: function(item) {
      setTimeout(function() {
        window.location.href = item;
      }, 300);
      return 'Veuillez patientez...';
    }
  });
  
  var corm_var = {};
  /*
   * Task Account Search Accounts bar & Contacts Field updates
   * GET tasks/_form
   */
  $('#account-search').typeahead({
    source: function(typeahead, query) {
      if (typeahead.trim().length < tolerance) {
        return false;
      }
      $.ajax({
          url: '/compte/search.json?account=' + typeahead,
          type: 'GET',
          dataType: 'json',
          beforeSend: function() {
            $(document.getElementById('contact_id')).html(corm.createHTML('option'));
            $(document.getElementById('account-search')).parent().children('.loading').removeClass('hidden');
          },
          success: function(o) {
            corm_var['account-search-typeahead'] = o.slice(0);
            query(o);
            var parent = $(document.getElementById('account-search')).parent();
            parent.children('.loading').addClass('hidden');
            parent.children('.label').show();
          }
      });
    },
    updater: function(item) {
      var i = corm_var['account-search-typeahead'], item;
      for (var index = 0; index < i.length; index++){
        if (i[index].id == item) {
          item = i[index];
          break;
        }
      }
      $(document.getElementById('account_id')).val(item.id);
      var select = $(document.getElementById('contact_id'));
      var contact_full_name = function(c) {
        return c.title + ' ' + c.forename + ' ' + c.surname;
      }
      /* getContacts */
      $.ajax({
        url: "/taches/update_contact_select/" + item.id,
        dataType: 'json',
        beforeSend: function() {
          select.parent().children('.loading').removeClass('hidden');
        },
        success: function(o) {
          for (var index in o) {
            select.append(corm.createHTML('option', { content: contact_full_name(o[index]) + '', value: o[index].id }));
          }
          select.parent().children('.loading').addClass('hidden');
        }
      });
      return item.name;
    }
  });
});