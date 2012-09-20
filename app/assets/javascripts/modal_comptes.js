$(function(){
    
//gestion de l'ajout de produit a un compte
  $("#compte_ajout_produit").click(function() {
    var prods = [];
    $('#produit option:selected').each(function(i,item) {
      prods[$(item).val()] = $(item).text();
    });
    //$('#produit option:selected').hide();
    $('#produit option:selected').remove();
    
    
    $.each(prods, function(key, value) {
      if(value){
	$('#compte_produit').append($('<option></option>').val(key).html(value));
      }
    });
    
  });  
 
  //gestion de la suppression de produit lié au compte
  $("#compte_retirer_produit").click(function() {
    var prods = [];
    $('#compte_produit option:selected').each(function(i,item) {
      prods[$(item).val()] = $(item).text();
    });
    
    $('#compte_produit option:selected').remove();
    
    $.each(prods, function(key, value) {
      if(value){
	//$("#produit option[value='"+key+"']").show();
	$('#produit').append($('<option></option>').val(key).html(value));
      }
    });
    
  });
  
  //retirer de la liste des produits à ajoutés les produits déja liés au compte
  $("#compte_ajout_button").click(function() {
    var prods = [];
    $('select#compte_produit').find('option').each(function(i,item) {
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
  $("#compte_valider_ajout").click(function() {
    
    var prods = [];
    $('select#compte_produit').find('option').each(function(i,item) {
      $(item).attr('selected',true);
      prods[$(item).val()] = $(item).text();
    });
    
    $('#display_compte_produit').find('option').each(function(i,item) {
      $(item).remove();
    });
    
    $.each(prods, function(key, value) {
      if(value){
	$('#display_compte_produit').append($('<option></option>').val(key).html(value));
      }
    });
    
    
  });
  
  //gestion lors de l'annulation
  $("#compte_annuler_ajout").click(function() {
    var prods = [];
    $('select#compte_produit').find('option').each(function(i,item) {
      $(item).attr('selected',false);
    });
    
  });
  
  //gestion validation formulaire
  $("#compte_validate_form").click(function() {
    
    $('select#display_compte_produit').attr('disabled',false);
    $('select#display_compte_produit').find('option').each(function(i,item) {
      $(item).attr('selected',true);
    }); 
  });
  
});