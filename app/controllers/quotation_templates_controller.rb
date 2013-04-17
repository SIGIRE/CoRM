# encoding: utf-8
class QuotationTemplatesController < ApplicationController
  
  ##
  # Show the full list of QuotationTemplate ordered by company by paginate_by
  #
  def index
    @page = params[:page]
    @templates =  QuotationTemplate.order('company').page(@page)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @templates}
    end
    
  end  
  
  ##
  # Render the page to create a new QuotationTemplate
  #
  def new
    if @ability.can? :create, QuotationTemplate
      @template = QuotationTemplate.new
      
      respond_to do |format|
        format.html  # new.html.erb
        format.json  { render :json => @template }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.QuotationTemplate'))
      redirect_to quotation_templates_url
      return false
    end
  end
  
  ##
  # Process to create a new QuotationTemplate
  #
  def create
    if @ability.can? :create, QuotationTemplate
      @template = QuotationTemplate.new(params[:quotation_template])
      @template.created_by = current_user.id   
      respond_to do |format|
        if @template.save
          format.html  { redirect_to quotation_templates_url, :notice => "Le modèle a été créé" }
          format.json  { render :json => @template,
                        :status => :created}
        else
          flash[:error] = t('app.save_undefined_error')
          format.html  { render :action => "new" }
          format.json  { render :json => @template.errors,
                        :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.QuotationTemplate'))
      redirect_to quotation_templates_url
      return false
    end
  end
  
  ##
  # Render the page to edit a QuotationTemplate
  #
  def edit
    if @ability.can? :update, QuotationTemplate
      @template = QuotationTemplate.find(params[:id])
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.QuotationTemplate'))
      redirect_to quotation_templates_url
      return false
    end
  end

  ##
  # Process to update an existing QuotationTemplate
  #
  def update
    if @ability.can? :update, QuotationTemplate
      @template = QuotationTemplate.find(params[:id])
      @template.updated_by = current_user.id    
      if @template.update_attributes(params[:quotation_template])
        redirect_to quotation_templates_url, :notice => "Le modèle a été mis à jour."
      else
        flash[:error] = t('app.save_undefined_error')
        render :action => 'edit'
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.QuotationTemplate'))
      redirect_to quotation_templates_url
      return false
    end
  end
  
  ##
  # Delete a QuotationTemplate in the Database
  #
  def destroy
    if @ability.can? :destroy, QuotationTemplate
      @template = QuotationTemplate.find(params[:id])
      @template.destroy
      redirect_to quotation_templates_url, :notice => "Le modèle a été supprimé."
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.QuotationTemplate'))
      redirect_to quotation_templates_url
      return false
    end
  end
  
end
