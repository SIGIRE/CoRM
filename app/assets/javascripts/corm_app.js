$(document).ready(function() {
  
  /* AlertBox fadeout */
  var alerts = $('.alert');
  setTimeout(function() {
    alerts.fadeOut(2000);
  }, 3000, function() {
    alerts.remove();
  });
  
  /* datepicker for all this classes/ids */
  if ($.datepicker) {
    var lang = $.datepicker.regional[ 'fr' ];
    $.datepicker.setDefaults({
      dateFormat: "dd/mm/yy"
    });
    $("#filter_begin").datepicker(lang);
    $("#filter_end").datepicker(lang);
    $("#tache_term").datepicker(lang);
    $(".event_date").datepicker(lang);
    $("#opportunity_term").datepicker(lang);
    $("#quotation_date").datepicker(lang);
    $("#task_term").datepicker(lang); 
  }
  if ($.validator) {
    /* jQuery Validator about .required class */
    $.validator.messages.required = "Ce champs est requis !";
    $('form').each(function() {
      $(this).validate();
    }); 
  }
  
  
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