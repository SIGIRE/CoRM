$(document).ready(function() {
  /* AlertBox fadeout */
  var alerts = $('.alert');
  setTimeout(function() {
    alerts.fadeOut(2000);
  }, 3000, function() {
    alerts.remove();
  });
  /* datepicker for all this classes/ids */
  $("#filter_begin").datepicker();
  $("#filter_end").datepicker();
  $("#tache_term").datepicker();
  $(".event_date").datepicker(); /* OK */
  $("#opportunity_term").datepicker(); /* OK */
  $("#quotation_date").datepicker();
  $("#task_term").datepicker();
  
  /* jQuery Validator about .required class */
  $.validator.messages.required = "Ce champs est requis !";
  $('form').each(function() {
    $(this).validate();
  });
  var navMenuBar = $('#nav-menu'), formSearchBar = $('#form-search'), accountField = $('#account');
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
        if (items[0].name) {
            info.by = 'id';
        } else {
            info.by = 'name';
        }
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
  
  $('.typeahead-search-account').each(function(index) {
    var that = this;
    var func, items;
    if ($(that).attr('data-function')) {
      func = $(that).attr('data-function');
    }
    $(this).typeahead({
      source: function (typeahead, query) {
        $.ajax({
          url: '/compte/search.json?account=' + typeahead,
          type: 'GET',
          dataType: 'json',
          success: function(o) {
            o[0].search = new Array();
            var classe = $(that).attr('class').split(' ');
            for (var i in classe) {
                classe[i].substr(0, 3) == 'by_' ? o[0].by = classe[i].substr(3, classe[i].length) : false;
                classe[i].substr(0, 3) == 'as_' ? o[0].as = classe[i].substr(3, classe[i].length) : false;
                classe[i].substr(0, 7) == 'search_' ? o[0].search.push(classe[i].substr(7, classe[i].length)) : false;
            }
            if (!o[0].by) {
              o[0].by = 'name';
            }
            if (!o[0].as) {
              o[0].as = 'value';
            }
            items = o.slice(0);
            var ok;
            for (var index = 1; index < o.length; index++) {
              ok = false;
              for (var i in o[0].search) {
                if (o[index].type == o[0].search[i]) {
                  ok = true;
                }
              }
              if (!ok) {
                o.splice(index, 1);
              }
            }
            query(o);
          }
        });
      },
      updater: function(item) {
        if (func) {
          var i = (function() {
            var by = items[0].by;
            for (var index = 1; index < items.length; index++) {
              console.log(items[index][by], item);
              if (items[index][by] && items[index][by] == item) {
                return items[index];
              }
            }
          })();
          eval(func);
          return f(i);
        } else if (items[0].as == 'url') {
          window.location = item;
        }
        
        return 'Veuillez patientez...';
      }
    });
  });

  /* Generate the contact list by accounts in task edition */
  var getContact = function(url, value, fn) {
    $.ajax({
      url: url + value,
      dataType: 'json',
      success: fn
    });
  };

  // Generate contact list in opportunity edtion
  $("#opportunity_account_id").change(function() {
    var account = $('select#opportunity_account_id :selected').val();
    if(account == "") { account="0"; }
  
    $.get('/opportunities/update_contact_select/' + account, 
      function(data){
        $("#nameContacts").html(data);
      }
    );
  });


  // Contact list generator in Quotation edition
  $("#quotation_account_id").change(function() {
  
    var account = $('select#quotation_account_id :selected').val();
    if(account == "") { account="0"; }
    if ($('#nameContact')) {
      $.get('/quotations/update_contact_select/' + account, 
        function(data){
            $("#nameContacts").html(data);
        }
      );
    }
    if ($('#nameOpportunity')) {
      $.get('/quotations/update_opportunity_select/' + account, 
        function(data){
            $("#nameOpportunity").html(data);
        }
      );
    }
    
    
  });
  
  // gestion de la check box lors de la creation d'un event
  $("#generate").change(function() {
    if($(this).is(':checked')){
      $("#task_values").show();
    } else {
      $("#task_values").hide();
    }
  });
  
  // Profil edition cancellation
  $("#profile_cancel").click(function() {
    $("#pwd").val('');
    $("#pwd_confirm").val('');
    $("#c_pwd").val('');
  });


  // Total amount excl. taxes
  $("#quotation_lines_attributes_0_quantity").change(function() {
    var qt = $(this).val();
    var prix = $("#quotation_lines_attributes_0_price_excl_tax").val();
    $("#quotation_lines_attributes_0_total_excl_tax").val(qt*prix);
    var ajout = Number($("#quotation_lines_attributes_0_total_excl_tax").val());
    $("#quotation_total_excl_tax").val(ajout);
  
  });

  $("#quotation_lines_attributes_0_price_excl_tax").change(function() {
    var qt = $("#quotation_lines_attributes_0_quantity").val();
    var prix = $(this).val();
    $("#quotation_lines_attributes_0_total_excl_tax").val(qt*prix);
  });
});
