class UserMailer < ActionMailer::Base
  default from: "crm@sigire.fr"
  
  def create_tache_email(user,task)
    @user = user
    @task = task
    @url = edit_task_path(task) #taches_path + @task.id.to_s
    mail(:to => user.email, :subject => "CRM : creation d'une nouvelle tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
  def update_tache_email(user,task)
    @user = user
    @task = task
    @url = edit_task_path(task)#"https://crm.ligepack.com/taches/" + @task.id.to_s
    mail(:to => user.email, :subject => "CRM : Mise a jour d'une tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
end
