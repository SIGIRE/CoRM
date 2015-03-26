# encoding: utf-8

##
# The Controller that manage Contract
#
class ContractsController < ApplicationController
  load_and_authorize_resource
  
  
  before_filter :authenticate_user!
  before_filter :load_account, :load_settings, only: [:index]
  layout :current_layout

  ##
  # Display the list of all Contracts by paginate_by
  #
  # GET /contracts
  # GET /contractsjson
  def index
    @contracts = Contract.order('name').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @contracts }
    end
  end
  
  ##
  # Render a page to create new Contract
  #
  def new
    @contract = Contract.new
    @contract.account_id = params[:account_id]    
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @contract }
    end
  end
  
  ##
  # Process to insert a new Contract into the DataBase
  #
  def create
    @contract = Contract.new(params[:contract])
    @contract.created_by = current_user.id

    respond_to do |format|
      if @contract.save
        format.html  { redirect_to contracts_path, :notice => "Le contrat a été créée." }
        format.json  { render :json => @contract, :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render a page to display an Contract
  #
  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @contract }
    end
  end
  
  def edit
    @contract = Contract.find(params[:id])
  end
  
  ##
  # Process that udpate an existing Contract
  #
  def update
    @contract = Contract.find(params[:id])
    @contract.updated_by = current_user.id

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html  { redirect_to(contracts_url, :notice => "Le contrat a été mise à jour.") }
        format.json  { head :no_content }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
        format.json  { render :json => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Process that remove an Contract from the DB
  #
  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url }
      format.json { head :no_content }
    end
  end
  
  
  
  
  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end
    
    def load_settings
      #ClickToCall
      @setting = Setting.all.first
    end    
    
    def contracts 
      @account ? @account.contracts : Contract
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end
    
    

end
