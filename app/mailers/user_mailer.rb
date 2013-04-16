class UserMailer < ActionMailer::Base
  default from: "crm@sigire.fr"
  
  def mail_for(user, object, created)
    @created_object = t("app.#{object.class.name}")
    @user = user
    @object = object
    @url = eval("edit_#{object.class.name}_url(@object)")
    action = created ? 'Creation' : 'Modification'
    subject = "CRM: #{action} d'une "
    subject += 'nouvelle ' if created
    subject += @created_object
    mail(:to => user.email, :subject => subject) do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
  def create_task_email(user,task)
    @user = user
    @task = task
    @url = edit_task_url(task)
    mail(:to => user.email, :subject => "CRM : creation d'une nouvelle tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
  def update_task_email(user,task)
    @user = user
    @task = task
    @url = edit_task_url(task)#"https://crm.ligepack.com/taches/" + @task.id.to_s
    mail(:to => user.email, :subject => "CRM : Mise a jour d'une tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end
  
end
