ActiveAdmin.register Compte do
  filter :societe
  filter :ville
  
  index do
    column :societe
    column :adresse1
    column :adresse2
    column :ville
    column :genre
    
    default_actions
  end
  
#  show do |compte|
#     h3 compte.societe + ' - ' + compte.adresse1 + ' - ' + compte.adresse2 + ' - ' + compte.cp + ' - ' + compte.ville
#  end


  
end
