# encoding: utf-8

##
# The Controller that manage Origin
#
class OriginsController < ApplicationController
  
  ##
  # Display the list of all Origins by paginate_by
  #
  # GET /origins
  # GET /origins.json
  def index
    @origins = Origin.order('name').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @origins }
    end
  end
  
  ##
  # Render a page to create new Origin
  #
  def new
    if @ability.can? :create, Origin
      @origin = Origin.new
      
      respond_to do |format|
        format.html  # new.html.erb
        format.json  { render :json => @origin }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Origin'))
      redirect_to origins_url
      return false
    end
  end
  
  ##
  # Process to insert a new Origin into the DataBase
  #
  def create
    if @ability.can? :create, Origin
      @origin = Origin.new(params[:origin])
      @origin.created_by = current_user.id
      
      respond_to do |format|
        if @origin.save
          format.html  { redirect_to origins_path, :notice => "L'origine a été créée." }
          format.json  { render :json => @origin, :status => :created}
        else
          format.html  { render :action => "new" }
          format.json  { render :json => @origin.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Origin'))
      redirect_to origins_url
      return false
    end
  end
  
  ##
  # Render a page to display an Origin
  #
  def show
    if @ability.can? :read, Origin
      @origin = Origin.find(params[:id])
     
      respond_to do |format|
        format.html  # show.html.erb
        format.json  { render :json => @origin }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Origin'))
      redirect_to origins_url
      return false
    end
  end
  
  def edit
    if @ability.can? :update, Origin
      @origin = Origin.find(params[:id])
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Origin'))
      redirect_to origins_url
      return false
    end
  end
  
  ##
  # Process that udpate an existing Origin
  #
  def update
    if @ability.can? :update, Origin
      @origin = Origin.find(params[:id])
      @origin.updated_by = current_user.id
     
      respond_to do |format|
        if @origin.update_attributes(params[:origin])
          format.html  { redirect_to(origins_url, :notice => "L'origine a été mis à jour.") }
          format.json  { head :no_content }
        else
          flash[:error] = t('app.save_undefined_error')
          format.html  { render :action => "edit" }
          format.json  { render :json => @origin.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Origin'))
      redirect_to origins_url
      return false
    end
  end
  
  ##
  # Process that remove an Origin from the DB
  #
  def destroy
    if @ability.can? :destroy, Origin
      @origin = Origin.find(params[:id])
      @origin.destroy
      respond_to do |format|
        format.html { redirect_to origins_url }
        format.json { head :no_content }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Origin'))
      redirect_to origins_url
      return false
    end
  end

end
