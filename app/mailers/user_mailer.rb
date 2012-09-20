class UserMailer < ActionMailer::Base
  default from: "crm@sigire.fr"
  
  def create_tache_email(user,tache)
    @user = user
    @tache = tache
    @url = "https://crm.ligepack.com/taches/" + @tache.id.to_s
    mail(:to => user.email, :subject => "CRM : creation d'une nouvelle tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
  def update_tache_email(user,tache)
    @user = user
    @tache = tache
    @url = "https://crm.ligepack.com/taches/" + @tache.id.to_s
    mail(:to => user.email, :subject => "CRM : Mise a jour d'une tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
end
