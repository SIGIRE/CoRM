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
  
  $("#filter_begin").datepicker();
  $("#filter_end").datepicker();
  $("#tache_term").datepicker();
  $(".event_date").datepicker(); /* OK */
  $("#opportunity_term").datepicker(); /* OK */
  $("#quotation_date").datepicker();
  $("#task_term").datepicker();
  
  //$('form').validate();
  $('form').each(function() {
    $(this).validate({});
  });
  
  $('#typeahead-search-account').on('keyup', function() {
    $(this).typeahead({
      source: function (typeahead, query) {
        return $.get('/compte/search', { query: query }, function (data) {
            return data;//typeahead.process(data);
        });
      }
    });
  });

  /* Generate the contact list in task edition */
  $("#task_account_id").change(function() {
  
    var account = $('select#task_account_id :selected').val();
    if(account == "") { account="0"; }
  
    $.get('/tasks/update_contact_select/' + account, 
      function(data){
          $("#nameContacts").html(data);
      }
    );
    if(account != "0"){
      $("#task_notice").show();
    } else{
      $("#task_notice").hide();
    }
  });

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
    
    $.get('/quotations/update_contact_select/' + account, 
      function(data){
          $("#nameContacts").html(data);
      }
    );
    $.get('/quotations/update_opportunity_select/' + account, 
      function(data){
          $("#nameOpportunity").html(data);
      }
    );
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