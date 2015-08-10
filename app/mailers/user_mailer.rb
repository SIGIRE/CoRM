class UserMailer < ActionMailer::Base
  default from: CORM[:mail][:from]

  def mail_for(user, object, created)
    @created_object = t("app.controllers.#{object.class.name}")
    @created = created
    @user = user
    @object = object
    logger.info("edit_#{object.class.name.downcase}_url(#{@object.id})")
    @url = eval("edit_#{object.class.name.downcase}_url(#{@object.id})")
    action = created ? 'Creation' : 'Modification'
    subject = "CRM: #{action} d'une "

    subject += 'nouvelle ' if created
    subject += @created_object
    mail(:to => user.email, :subject => subject) do |format|
      #format.text(:content_transfer_encoding => "base64")
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
    @url = edit_task_url(task)
    mail(:to => user.email, :subject => "CRM : Mise a jour d'une tache") do |format|
      format.text(:content_transfer_encoding => "base64")
      format.html
    end
  end

end
