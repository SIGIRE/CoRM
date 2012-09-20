$(function(){
    
//gestion de l'ajout de produit a un compte
  $("#contact_ajout_produit").click(function() {
    var prods = [];
    $('#produit option:selected').each(function(i,item) {
      prods[$(item).val()] = $(item).text();
    });
    //$('#produit option:selected').hide();
    $('#produit option:selected').remove();
    
    
    $.each(prods, function(key, value) {
      if(value){
	$('#contact_produit').append($('<option></option>').val(key).html(value));
      }
    });
    
  });  
 
  //gestion de la suppression de produit lié au compte
  $("#contact_retirer_produit").click(function() {
    var prods = [];
    $('#contact_produit option:selected').each(function(i,item) {
      prods[$(item).val()] = $(item).text();
    });
    
    $('#contact_produit option:selected').remove();
    
    $.each(prods, function(key, value) {
      if(value){
	//$("#produit option[value='"+key+"']").show();
	$('#produit').append($('<option></option>').val(key).html(value));
      }
    });
    
  });
  
  //retirer de la liste des produits à ajoutés les produits déja liés au compte
  $("#contact_ajout_button").click(function() {
    var prods = [];
    $('select#contact_produit').find('option').each(function(i,item) {
      prods[$(item).val()] = $(item).text();
    });
    
    $.each(prods, function(key, value) {
      if(value){
	//$("#produit option[value='"+key+"']").hide();
	$("#produit option[value='"+key+"']").remove();
      }
    });
    
  });
  
  //selectionner tous les produits de la liste lié au compte lors de validation
  $("#contact_valider_ajout").click(function() {
    
    var prods = [];
    $('select#contact_produit').find('option').each(function(i,item) {
      $(item).attr('selected',true);
      prods[$(item).val()] = $(item).text();
    });
    
    $('#display_contact_produit').find('option').each(function(i,item) {
      $(item).remove();
    });
    
    $.each(prods, function(key, value) {
      if(value){
	$('#display_contact_produit').append($('<option></option>').val(key).html(value));
      }
    });
    
    
  });
  
  //gestion lors de l'annulation
  $("#contact_annuler_ajout").click(function() {
    var prods = [];
    $('select#contact_produit').find('option').each(function(i,item) {
      $(item).attr('selected',false);
    });
    
  });
  
  //gestion validation formulaire
  $("#contact_validate_form").click(function() {
    
    $('select#display_contact_produit').attr('disabled',false);
    $('select#display_contact_produit').find('option').each(function(i,item) {
      $(item).attr('selected',true);
    }); 
  });
  
});