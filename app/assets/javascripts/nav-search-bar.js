$(document).ready(function() {
  
  var navMenuBar = $('#nav-menu'), formSearchBar = $('#form-search'), accountField = $('#main-search-bar');
  /* AccountSearchBar Animation */
  accountField.on('focus', function() {
    corm.AccountFieldIsFocused = true;
    formSearchBar.addClass('focus');
  });
  accountField.on('blur', function() {
    corm.AccountFieldIsFocused = false;
    formSearchBar.removeClass('focus');
  });
  formSearchBar.on('submit', function() {
    corm.AccountFieldIsFocused = false;
    formSearchBar.removeClass('focus');
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
          url: '/compte/search.json?contacts=true&account='.concat(typeahead),
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
      window.location.href = item;

      return 'Veuillez patientez...';
    }
  });
  
  var corm_var = {};
  /*
   * Abstract Task Account Search Accounts bar & Contacts Field updates
   * GET taches/_form
   */
  $('.typeahead-account-search').each(function() {
    var that = this;
    $(that).typeahead({
      source: function(typeahead, query) {
        if (typeahead.trim().length < tolerance) {
          return false;
        }
        
        $.ajax({
            url: '/compte/search.json?account=' + typeahead,
            type: 'GET',
            dataType: 'json',
            beforeSend: function() {
              var contact_list = document.getElementById('contact_id');
              if (contact_list) {
                $(contact_list).html(corm.createHTML('option'));
              }
              $(that).parent().children('.loading').removeClass('hidden');
            },
            success: function(o) {
              corm_var['account-search-typeahead'] = o.slice(0);
              query(o);
              var parent = $(that).parent();
              parent.children('.loading').addClass('hidden');
              var label = parent.children('.label');
              if (label.hide) {
                label.hide();
              }
              
            }
        });
      },
      updater: function(item) {
        var i = corm_var['account-search-typeahead'], item;
        for (var index = 0; index < i.length; index++) {
          if (i[index].id == item) {
            item = i[index];
            break;
          }
        }
        if (item.name != null && item.name != '') {
            var label = $(that).parent().children('.label');
          if (label.show) {
            label.show();
          }
        }
        $(document.getElementById(that.getAttribute('data-field'))).val(item.id);
        var select_dom = document.getElementById('contact_id');
        if (select_dom) {
          var select = $(select_dom);
          var contact_full_name = function(c) {
            return c.title + ' ' + c.forename + ' ' + c.surname;
          }
          /* getContacts */
          $.ajax({
            url: "/taches/update_contact_select/".concat(item.id),
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
        }
        return item.name;
      }
    });
  });
});