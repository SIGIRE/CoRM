$(document).ready(function() {
  
  /* AlertBox fadeout */
  var alerts = $('.alert');
  setTimeout(function() {
    alerts.css({
      top: '-=200px'  
    })
  }, 5000);
  
  /* Form contact on Account_Event view  */
  var form_contact__account_event__view = $('#new_contact');
  form_contact__account_event__view.submit(function() {
    
    $.ajax({
      url: form_contact__account_event__view.attr('action'),
      type: 'post',
      data: form_contact__account_event__view.serialize(),
      dataType: 'json',
      success: function(o) {
        var contact_div = corm.createHTML('div', { 'class': 'contact-container' });
        
        var a = corm.createHTML('a', { href: form_contact__account_event__view.attr('action') + '/edit', title: 'Editer le contact' });
        
        contact_div.appendChild(a);
        
        if (o.title == 'Mme') {
          a.appendChild(corm.createHTML('img', { src: '/assets/glyphicons/glyphicons_035_woman.png' }));
        } else {
          a.appendChild(corm.createHTML('img', { src: '/assets/glyphicons/glyphicons_034_old_man.png' }));
        }
        var p = document.createElement('p');
        contact_div.appendChild(p);
        p.appendChild(corm.createHTML('b', { content: o.title + ' ' + o.forename + ' ' + o.surname }));
        p.appendChild(document.createElement('br'));
        if (o.tel != null && o.tel.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_tel', content: o.tel }));
          p.appendChild(document.createElement('br'));
        }
        if (o.fax != null && o.fax.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_fax', content: o.fax }));
          p.appendChild(document.createElement('br'));
        }
        if (o.mobile != null && o.mobile.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_tel', content: o.mobile }));
          p.appendChild(document.createElement('br'));
        }
        if (o.email != null && o.email.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_tel', content: o.email }));
          p.appendChild(document.createElement('br'));
        }
        document.getElementById('contacts_list').appendChild(contact_div);
        
        corm.getContactsByAccount('event_contact_id', o.account_id);
        corm.addAlert('notice', 'Le contact a été correctement créé.');
        
        window.scrollTo(0, 0);
        
      },
      error: function(o) {
        console.log('this is an error', o);
      }
    });
    return false;
  });
  
  $(document).on('click', '#listing-event .event', function() {
    var div = $(this).find('div.more');
    div.toggle();
  });
  var check_event_more_fn = function() {
    var checked = $(this).children('input').is(':checked');
    if (checked) {
      $('#listing-event .more').show();
    } else {
      $('#listing-event .more').hide();
    }
  };
  $(document).on('click', '#toggle-events-more', check_event_more_fn);
  check_event_more_fn.call(document.getElementById('toggle-events-more'));
  
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
            $(document.getElementById('nameContacts')).html(data);
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