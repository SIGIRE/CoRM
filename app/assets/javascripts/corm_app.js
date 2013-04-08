var BrowserDetect = {
  init: function () {
    this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
    this.version = this.searchVersion(navigator.userAgent)
      || this.searchVersion(navigator.appVersion)
      || "an unknown version";
    this.OS = this.searchString(this.dataOS) || "an unknown OS";
  },
  searchString: function (data) {
    for (var i=0;i<data.length;i++) {
      var dataString = data[i].string;
      var dataProp = data[i].prop;
      this.versionSearchString = data[i].versionSearch || data[i].identity;
      if (dataString) {
        if (dataString.indexOf(data[i].subString) != -1)
          return data[i].identity;
      }
      else if (dataProp)
        return data[i].identity;
    }
  },
  searchVersion: function (dataString) {
    var index = dataString.indexOf(this.versionSearchString);
    if (index == -1) return;
    return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
  },
  dataBrowser: [
    {
      string: navigator.userAgent,
      subString: "Chrome",
      identity: "Chrome"
    },
    {
      string: navigator.userAgent,
      subString: "OmniWeb",
      versionSearch: "OmniWeb/",
      identity: "OmniWeb"
    },
    {
      string: navigator.vendor,
      subString: "Apple",
      identity: "Safari",
      versionSearch: "Version"
    },
    {
      prop: window.opera,
      identity: "Opera",
      versionSearch: "Version"
    },
    {
      string: navigator.vendor,
      subString: "iCab",
      identity: "iCab"
    },
    {
      string: navigator.vendor,
      subString: "KDE",
      identity: "Konqueror"
    },
    {
      string: navigator.userAgent,
      subString: "Firefox",
      identity: "Firefox"
    },
    {
      string: navigator.vendor,
      subString: "Camino",
      identity: "Camino"
    },
    {               // for newer Netscapes (6+)
      string: navigator.userAgent,
      subString: "Netscape",
      identity: "Netscape"
    },
    {
      string: navigator.userAgent,
      subString: "MSIE",
      identity: "Explorer",
      versionSearch: "MSIE"
    },
    {
      string: navigator.userAgent,
      subString: "Gecko",
      identity: "Mozilla",
      versionSearch: "rv"
    },
    {               // for older Netscapes (4-)
      string: navigator.userAgent,
      subString: "Mozilla",
      identity: "Netscape",
      versionSearch: "Mozilla"
    }
  ],
  dataOS : [
    {
      string: navigator.platform,
      subString: "Win",
      identity: "Windows"
    },
    {
      string: navigator.platform,
      subString: "Mac",
      identity: "Mac"
    },
    {
      string: navigator.userAgent,
      subString: "iPhone",
      identity: "iPhone/iPod"
    },
    {
      string: navigator.platform,
      subString: "Linux",
      identity: "Linux"
    }
  ]

};
BrowserDetect.init();


$(document).ready(function() {
  var alerts = $('.alert');
  setTimeout(function() {
    alerts.fadeOut(2000);
  }, 3000, function() {
    alerts.remove();
  });
  $("#filter_begin").datepicker();
  $("#filter_end").datepicker();
  $("#tache_term").datepicker();
  $(".event_date").datepicker(); /* OK */
  $("#opportunity_term").datepicker(); /* OK */
  $("#quotation_date").datepicker();
  $("#task_term").datepicker();
  
  $.validator.messages.required = "Ce champs est requis !";
  $('form').each(function() {
    $(this).validate();
  });
  
  /* Search account bar */
  $('.typeahead-search-account').each(function(index) {
    var that = $(this);
    that.typeahead({
      source: function (typeahead, query) {
        $.ajax({
          url: '/compte/search?account=' + typeahead,
          type: 'GET',
          dataType: 'json',
          success: function(o) {
            that.dataSource = o, companies = new Array();
            for (var i in o) {
              companies.push(i);
            }
            query(companies);
          }
        });
      },
      updater: function(item) {
        if (that.hasClass('not-links')) {
          corm.getContactsByAccount(item);
        } else {
          var id = null;
          for (var i in that.dataSource) {
            if (i == item) {
              id = that.dataSource[i]; break;
            }
          }
          if (id) {
            window.location.href = '/compte/'+id+'/evenements';
          }
        }
        return item;
      }
    });
  });

  /* Generate the contact list by accounts in task edition */
  

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