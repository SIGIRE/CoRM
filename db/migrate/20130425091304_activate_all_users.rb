class ActivateAllUsers < ActiveRecord::Migration
  def change
       User.all.each do | u |
         u.update_attribute(:enabled,true)
       end

       u=User.new
       u.forename="Admin"
       u.surname="COMPANY"
       u.password="password"
       u.email="admin@domain.tld"
       u.enabled=true
       #u.id=User.last.id+1
       u.save
       u.add_role(:admin)
  end

end
