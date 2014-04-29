$(document).ready(function() {
  
  /* AlertBox fadeout */
  var alerts = $('.alert');
  setTimeout(function() {
    alerts.each(function() {
      this.setAttribute('style', 'top: -200px;');
    });
  }, 5000);
  $(document.getElementById('link_to_close_alert')).click(function() {
    alerts.each(function() {
      this.setAttribute('style', 'top: -200px;');
    });
  });
  $(document).on('keyup', function(e) {
    if (e.which == 27) { // on ESCAPE
      alerts.each(function() {
        this.setAttribute('style', 'top: -200px;');
      });
    }
  });
  var current_user = document.getElementById('current_user'), current_user_id = '';
  if (current_user) {
    current_user_id = current_user.getAttribute('data-id');
  }
  
  $('.assigned_to').change(function() {
    var checkbox = $(this).parent().find('input[type=checkbox]');
    if ($(this).val() != current_user_id && !$(this).is(':checked')) {
      checkbox.attr('checked', 'checked');
    } else {
      checkbox.attr('checked', null);
    }
  });
  $(document.getElementById('event_user_id')).change(function() {
    var checkbox = $(document.getElementById('mail'));
    if ($(this).val() != current_user_id) {
      checkbox.attr('checked', true);
    } else {
      checkbox.attr('checked', false);
    }
  });
  
  /* Form contact on Account_Event view  */
  var form_contact__account_event__view = $('#new_contact');
  form_contact__account_event__view.submit(function() {
    
    $.ajax({
      url: form_contact__account_event__view.attr('action'),
      type: 'post',
      data: form_contact__account_event__view.serialize(),
      dataType: 'json',
      success: function(o) {
        var contact = o.contact;
        
        var contact_div = corm.createHTML('div', { 'class': 'contact-container' });
        
        var a = corm.createHTML('a', { href: o.paths.edit, title: 'Editer le contact' });
        contact_div.appendChild(a);
        contact.job = contact.job ? '('.concat(contact.job, ')') : '';
        var  i = corm.createHTML('i', { 'class': 'contact-job', content: contact.job });
        contact_div.appendChild(i);
        
        if (contact.title == 'Mme') {
          a.appendChild(corm.createHTML('img', { src: '/assets/glyphicons/glyphicons_035_woman.png' }));
        } else if (contact.title == 'M.') {
          a.appendChild(corm.createHTML('img', { src: '/assets/glyphicons/glyphicons_034_old_man.png' }));
        } else {
          a.appendChild(corm.createHTML('img', { src: '/assets/glyphicons/no_title.png', width: 18, height: 18 }));
        }
        var p = document.createElement('p');
        contact_div.appendChild(p);
        p.appendChild(corm.createHTML('b', { content: contact.title.concat(' ', contact.forename, ' ', contact.surname) }));
        p.appendChild(document.createElement('br'));
        if (contact.tel != null && contact.tel.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_tel', content: 'Tel : '.concat(contact.tel) }));
          p.appendChild(document.createElement('br'));
        }
        if (contact.fax != null && contact.fax.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_fax', content: 'Fax : '.concat(contact.fax) }));
          p.appendChild(document.createElement('br'));
        }
        if (contact.mobile != null && contact.mobile.length > 0) {
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_mob', content: 'Mobile : '.concat(contact.mobile) }));
          p.appendChild(document.createElement('br'));
        }
        if (contact.email != null && contact.email.length > 0) {
          var a_email = corm.createHTML('a', { 'class': 'ellipse', content: contact.email, href: 'mailto:'.concat(contact.email) })
          
          p.appendChild(corm.createHTML('span', { 'class': 'info_contact_email', content: a_email }));
          p.appendChild(document.createElement('br'));
        }
        
        if (contact_div.lastChild.lastChild.localName == 'br') {
          var br = contact_div.lastChild.lastChild;
          contact_div.lastChild.removeChild(br);
        }
        var contact_list = document.getElementById('contacts_list');
        contact_list.appendChild(contact_div);
        var hr = $(document.getElementById('contact-hr'))
        if (!hr.is(':visible')) {
          hr.show();
        }
        corm.getContactsByAccount('event_contact_id', contact.account_id);
        alertify.success("Contact créé.");
        window.scrollTo(0, 0);
        form_contact__account_event__view[0].reset();
      },
      error: function(o) {
        window.scrollTo(0, 0);
        var errorMessage = JSON.parse(o.responseText);
        if (errorMessage) {
          alertify.error(errorMessage);
        }
        
      }
    });
    return false;
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
  
  $(document).on('click', '#listing-event .event', function() {
    $(this).find('.more').toggle();
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
    $(document.getElementsByClassName('filter_date')).datepicker(lang);
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

  /*
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
  });*/
  
  // gestion de la check box lors de la creation d'un event
  $(document.getElementById('account_search_field')).on('keyup', function(e) {
    if($(this).val() == '') {
      $(document.getElementById('generate_task')).attr('checked', false);
      if ($(document.getElementById('row_for_generate')).is(':visible')) { // visible
        $(document.getElementById('task_task_value')).hide();
        $(document.getElementById('row_for_generate')).slideUp();
      }
      return false;
    } else {
      if (!$(document.getElementById('row_for_generate')).is(':visible')) {
        $(document.getElementById('row_for_generate')).slideDown();
      }
    }
    return false;
  });
  // Manage checkbox to toggle 
  $('.toggle-checkbox').change(function() {
      var that = $(this),
          state = that.is(':checked'),
          container = $(document.getElementById(that.attr('data-toggle'))).clone(true),
          inputs = $(container).find('label.checkbox input[type=checkbox]');
      inputs.each(function(i, v) {
          if (state) {
              v.setAttribute('checked', 'checked');
          } else {
              v.removeAttribute('checked');
          }
      });
      var HTMLContainer = $(document.getElementById(that.attr('data-toggle')));
      HTMLContainer.html(container.children());
  });
  
  // Cette fonction gère le fait d'afficher/cacher un bloc task_value au click sur la checkbox generate
  $(document.getElementById('generate')).on('change', function() {
    if ($(this).is(':checked') && !$(document.getElementById('task_value')).is(':visible')) {
      $(document.getElementById('task_value')).slideDown();
    } else if (!$(this).is(':checked') && $(document.getElementById('task_value')).is(':visible')) {
      $(document.getElementById('task_value')).slideUp();
    }
    
  });

  // Idem, fonction doublée pour le cas des évènements : on a deux checkboxes et deux blocs à cacher/afficher.
  // À refactoriser, en passant par des classes et des attributs data plutôt que des ids.
  $(document.getElementById('generate_task')).on('change', function() {
    if ($(this).is(':checked') && !$(document.getElementById('task_task_value')).is(':visible')) {
      $(document.getElementById('task_task_value')).slideDown();
    } else if (!$(this).is(':checked') && $(document.getElementById('task_task_value')).is(':visible')) {
      $(document.getElementById('task_task_value')).slideUp();
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
  
  
  /* Upload file Settings */
  var input, formdata=false, reader = new FileReader();
  
  if ($('.edit_setting').length > 0) {
      
      if (window.FormData) {
          formdata = new FormData();
      }
      var forms = $('.edit_setting'),
            form=null,
            inputFiles=null;
            
      for(var n=0;n<forms.length;n += 1) {
        form = $(forms[n]);
        inputFiles = form.find('input[type=file]');
        inputFiles.change(function(event) {
            reader = new FileReader();  
            var i = 0, len = this.files.length, img, reader, file;
            for( ; i < len; i++) {
                file = this.files[i];
                console.log(file);
                reader.readAsDataURL(file);
                formdata.append('setting[file]', file);
            }
        });
      }
      
      
      $('.edit_setting').submit(function() {
            var form = $(this);
            formdata.append('setting[value]', form.find('.setting_value').val())
            formdata.append('setting[key]', form.find('.setting_key').val());
            formdata.append('setting[type]', form.find('.setting_type').val());
            formdata.append('_method', form.find('input[name=_method]').val());
            $.ajax({
                url: form.attr('action'),
                type: 'POST',
                data: formdata,
                processData: false,  
                contentType: false, 
                beforeSend: function() {
                    form.find('.small-message').hide();
                },
                success: function(o) {
                    if (o.saved) {
                        var message = form.find('.small-message').show();
                        setTimeout(function() {
                            message.fadeOut(2000);
                        }, 2000);
                    }
                }
            });
            return false;
      });
  }
});
