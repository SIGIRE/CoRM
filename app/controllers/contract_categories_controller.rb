# encoding: utf-8

##
# The Controller that manage ContractCategory
#
class ContractCategoriesController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all Contract_categories by paginate_by
  #
  # GET /contract_categories
  # GET /contract_categories.json
  def index
    @contractcategories = ContractCategory.order('name').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @contractcategories }
    end
  end
  
  ##
  # Render a page to create new ContractCategory
  #
  def new
    @contract_category = ContractCategory.new
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @contract_category }
    end
  end
  
  ##
  # Process to insert a new ContractCategory into the DataBase
  #
  def create
    @contract_category = ContractCategory.new(params[:contract_category])
    @contract_category.created_by = current_user.id

    respond_to do |format|
      if @contract_category.save
        format.html  { redirect_to contract_categories_path, :notice => "La catégorie de contrat a été créée." }
        format.json  { render :json => @contract_category, :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @contract_category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render a page to display an ContractCategory
  #
  def show
    @contract_category = ContractCategory.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @contract_category }
    end
  end
  
  def edit
    @contract_category = ContractCategory.find(params[:id])
  end
  
  ##
  # Process that udpate an existing ContractCategory
  #
  def update
    @contract_category = ContractCategory.find(params[:id])
    @contract_category.updated_by = current_user.id

    respond_to do |format|
      if @contract_category.update_attributes(params[:contract_category])
        format.html  { redirect_to(contract_categories_url, :notice => "La catégorie de contrat a été mise à jour.") }
        format.json  { head :no_content }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
        format.json  { render :json => @contract_category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Process that remove an ContractCategory from the DB
  #
  def destroy
    @contract_category = ContractCategory.find(params[:id])
    @contract_category.destroy
    respond_to do |format|
      format.html { redirect_to contract_categories_url }
      format.json { head :no_content }
    end
  end

end
