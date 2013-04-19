$(document).ready(function() {
  
  /* AlertBox fadeout */
  var alerts = $('.alert');
  setTimeout(function() {
    alerts.fadeOut(2000);
  }, 3000, function() {
    alerts.remove();
  });
  
  $(document).on('click', '#listing-event .event', function() {
    var div = $(this).find('div.more');
    div.toggle();
  });
  $(document).on('click', '#toggle-events-more', function() {
    var checked = $(this).children('input').is(':checked');
    if (checked) {
      $('#listing-event .more').show();
    } else {
      $('#listing-event .more').hide();
    }
  });
  
  /* datepicker for all this classes/ids */
  if ($.datepicker) {
    var lang = $.datepicker.regional[ 'fr' ];
    $.datepicker.setDefaults({
      dateFormat: "dd/mm/yy"
    });
    $(document.getElementById('filter_begin')).datepicker(lang);
    $(document.getElementById('filter_end')).datepicker(lang);
    $(document.getElementById('tache_term')).datepicker(lang);
    $(document.getElementsByClassName('event_date')).datepicker(lang);
    $(document.getElementById('opportunity_term')).datepicker(lang);
    $(document.getElementById('quotation_date')).datepicker(lang);
    $(document.getElementById('task_term')).datepicker(lang); 
  }
  if ($.validator) {
    /* jQuery Validator about .required class */
    $.validator.messages.required = "Ce champs est requis !";
    $('form:not(#new_user)').each(function() {
      $(this).validate();
    }); 
  }
  
  
  // Generate contact list in opportunity edtion
  $(document.getElementById('opportunity_account_id')).change(function() {
    var account = $('select#opportunity_account_id :selected').val();
    if(account == "") { account="0"; }
  
    $.get('/opportunites/update_contact_select/' + account, 
      function(data){
        $(document.getElementById('nameContacts')).html(data);
      }
    );
  });
  
  
  // Contact list generator in Quotation edition
  $(document.getElementById('quotation_account_id')).change(function() {
  
    var account = $('select#quotation_account_id :selected').val();
    if(account == "") { account="0"; }
    if ($(document.getElementById('nameContact'))) {
      $.get('/devis/update_contact_select/' + account, 
        function(data){
            $("#nameContacts").html(data);
        }
      );
    }
    if ($(document.getElementById('nameOpportunity'))) {
      $.get('/devis/update_opportunity_select/' + account, 
        function(data){
            $(document.getElementById('nameOpportunity')).html(data);
        }
      );
    }
  });
  
  // gestion de la check box lors de la creation d'un event
  $(document.getElementById('generate')).change(function() {
    if($(this).is(':checked')){
      $(document.getElementById('task_values')).show();
    } else {
      $(document.getElementById('task_values')).hide();
    }
  });
  
  // Profil edition cancellation
  $(document.getElementById('profile_cancel')).click(function() {
    $(document.getElementById('#pwd')).val('');
    $(document.getElementById('#pwd_confirm')).val('');
    $(document.getElementById('c_pwd')).val('');
  });
  
  
  // Total amount excl. taxes
  $(document.getElementById('quotation_lines_attributes_0_quantity')).change(function() {
    var qt = $(this).val();
    var prix = $(document.getElementById('quotation_lines_attributes_0_price_excl_tax')).val();
    $(document.getElementById('quotation_lines_attributes_0_total_excl_tax')).val(qt*prix);
    var ajout = Number($(document.getElementById('quotation_lines_attributes_0_total_excl_tax')).val());
    $(document.getElementById('quotation_total_excl_tax')).val(ajout);
  
  });
  
  $(document.getElementById('quotation_lines_attributes_0_price_excl_tax')).change(function() {
    var qt = $(document.getElementById('quotation_lines_attributes_0_quantity')).val();
    var prix = $(this).val();
    $(document.getElementById('quotation_lines_attributes_0_total_excl_tax')).val(qt*prix);
  });

});