$(function() {
    
    /**
    * Get the list of tags by id
    * @param {String} tag|account
    * @return {Array} Array of tags [val => text]
    */
    var getTagsList = function(selector) {
        var tags = new Array(), that;
	selector = selector.indexOf('#') == -1 ? '#' + selector : selector;
        $(selector).each(function(i) {
            that = $(this);
	    if (that.text() == undefined) { return; }
            tags[that.val()] = that.text();
        });
        return tags;
    };

    /* Init */
    var initial_tags = getTagsList('tag option'), initial_tags_account = getTagsList('account_tag option');
    
    /* Adding a tag to an Acccount Handler */
    $("#account_add_tag").click(function() {
        var tags = getTagsList('tag option:selected'), account_tagHTML = $('#account_tag');
        
	for (var key in tags) {
	    if (tags[key])
		account_tagHTML.append(
		    corm.createHTML('option', {
			content: tags[key],
			value: key
		    })
		);
	}
	$('#tag option:selected').remove();
    });  
 
  /* Remove a tag from the Account tag list */
  $("#account_remove_tag").click(function() {
    var tags = getTagsList('account_tag option:selected'), tagHTML = $('#tag');
    for (var key in tags) {
	if (tags[key])
	    tagHTML.append(
		corm.createHTML('option', {
		    content: tags[key],
		    value: key
		})
	    );	
    }
    $('#account_tag option:selected').remove();
  });
  
  /* Remove from the Tags list, tags which are already linked to the account */
  $("#account_add_button").click(function() {
    var tags = getTagsList('select#account_tag option');
    for (var key in tags){
	$('#tag option[value="' + key + '"]').remove();
    }
  });
  
  /* Get all tags linked to the account in the modal window and add it to the main form for edition/creation */
  $("#account_submit_add").click(function() {
    var tags = getTagsList('select#account_tag option');
    /* Empty the list of tags in the main form for creation/edition */
    var main_form_select_tags = $('#display_account_tag');
    main_form_select_tags.html('');
    for (var key in tags) {
	/*tags[key].setAttribute('selected', 'true');*/
	main_form_select_tags.append(
	    corm.createHTML('option', {
		content: tags[key],
		value: key
	    })
	);
    }
    initial_tags = getTagsList('select#tag option');
    initial_tags_account = tags.slice(0);
  });
  
  /* Manage cancellation */
  $("#account_cancel_add").click(function() {
    var account_tagHTML = $('select#account_tag'), tagHTML = $('select#tag'), key;
    account_tagHTML.html('');
    tagHTML.html('');
    for (key in initial_tags_account) {
	account_tagHTML.append(
	    corm.createHTML('option', {
		content: initial_tags_account[key],
		value: key
	    })
	);
    }
    for (key in initial_tags) {
	tagHTML.append(
	    corm.createHTML('option', {
		content: initial_tags[key],
		value: key
	    })
	);
    }
  });
  
  /* Check before submit */
  $("#account_validate_form").click(function() {
    var select = $('select#display_account_tag');
    /* Be sure the select field is not disabled */
    select.attr('disabled',false);
    select.find('option').each(function() {
        $(this).attr('selected', true);
    }); 
  });
  
});
