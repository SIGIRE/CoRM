class ActivateAllUsers < ActiveRecord::Migration
  def change
       User.all.each do | u |
         u.update_attribute(:enabled,true)
       end
      
       u=User.new
       u.forename="Admin"
       u.surname="SIGIRE"
       u.password="Fikergn43653"
       u.email="admin@sigire.fr"
       u.enabled=true
       #u.id=User.last.id+1
       u.save
       u.add_role(:admin)
  end

end
