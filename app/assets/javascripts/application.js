//= require jquery
//= require jquery_ujs
//= require ./modal_comptes.js
//= require ./modal_contacts.js
//= require bootstrap
//= require ./jquery-1.7.2.min.js
//= require ./jquery-ui-1.8.21.custom.min.js
//= require ./jquery.ui.datepicker-fr.js





$(function(){

  $("#filter_debut").datepicker();
  $("#filter_fin").datepicker();
  $("#tache_echeance").datepicker();
  $("#evenement_debut").datepicker();
  $("#evenement_fin").datepicker();
  $("#opportunite_echeance").datepicker();
  $("#devi_date").datepicker();
  
  
  //generation dynamique de la liste "contact" dans l'edition de tache
  $("#tache_compte_id").change(function() {
    
    // make a POST call and replace the content
    var compte = $('select#tache_compte_id :selected').val();
    if(compte == "") compte="0";
    
    jQuery.get('/taches/update_contact_select/' + compte, function(data){
      $("#nameContacts").html(data);
    });
  
    // afficher un message indicatif sur la creation d'evenement
    if(compte != "0"){
      $("#tache_notice").show();
    }
    else{
      $("#tache_notice").hide();
    }
  });


  //generation dynamique de la liste "contact" dans l'edition d'opportunité
  $("#opportunite_compte_id").change(function() {
    
    // make a POST call and replace the content
    var compte = $('select#opportunite_compte_id :selected').val();
    if(compte == "") compte="0";
    
    jQuery.get('/opportunites/update_contact_select/' + compte, function(data){
      $("#nameContacts").html(data);
    });
  });
  
  
    //generation dynamique de la liste "contact" dans l'edition d'un devis
  $("#devi_compte_id").change(function() {
    
    // make a POST call and replace the content
    var compte = $('select#devi_compte_id :selected').val();
    if(compte == "") compte="0";
    
    jQuery.get('/devis/update_contact_select/' + compte, function(data){
      $("#nameContacts").html(data);
    });
  });
  
  //generation dynamique de la liste "opportunite" dans l'edition d'un devis
  $("#devi_compte_id").change(function() {
    
    // make a POST call and replace the content
    var compte = $('select#devi_compte_id :selected').val();
    if(compte == "") compte="0";
    
    jQuery.get('/devis/update_opportunite_select/' + compte, function(data){
      $("#nameOpportunite").html(data);
    });
  });
  
  
  // gestion de la check box lors de la creation d'un event
  $("#generate").change(function() {
    if($("#generate").is(':checked')){
      $("#tache_values").show();
    }
    else{
      $("#tache_values").hide();
    }
  
  });

  //gestion lors de l'annulation du modal dans l'edition du profil
  $("#profil_annuler").click(function() {
    $("#pwd").val('');
    $("#pwd_confirm").val('');
    $("#c_pwd").val('');
  });

  
  //calcul dynamique du total ht d'un item
  $("#devi_items_attributes_0_quantite").change(function() {
    var qt = $("#devi_items_attributes_0_quantite").val();
    var prix = $("#devi_items_attributes_0_prix_ht").val();
    $("#devi_items_attributes_0_total_ht").val(qt*prix);
    var ajout = Number($("#devi_items_attributes_0_total_ht").val());
    $("#devi_total_ht").val(ajout);
    
  });
  
  $("#devi_items_attributes_0_prix_ht").change(function() {
    var qt = $("#devi_items_attributes_0_quantite").val();
    var prix = $("#devi_items_attributes_0_prix_ht").val();
    $("#devi_items_attributes_0_total_ht").val(qt*prix);
  });

});


