# encoding: utf-8

##
# The Controller that manage Contract
#
class ContractsController < ApplicationController
  load_and_authorize_resource
  
  before_filter :authenticate_user!
  before_filter :load_account, :load_settings, only: [:index]
  layout :current_layout

  has_scope :by_account_company_like
  has_scope :by_description_like
  has_scope :by_category_id
  
  ##
  # Display the list of all Contracts by paginate_by
  #
  # GET /contracts
  # GET /contractsjson
  def index
    
    default_order = 'name'
    default_direction = 'DESC'
    @sort = params[:sort] || default_order
    @direction = params[:direction] || default_direction
    
    @contracts_all = apply_scopes(contracts).order("#{@sort} #{@direction}")
                     
    @contracts = @contracts_all.page(params[:page])

    @contracts_scopes = current_scopes    
    

    flash.now[:alert] = "Pas de contrat !" if @contracts.empty?
    
    respond_to do |format|
      format.html  # index.html.erb
      format.xlsx # index.xlsx.axlsx
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
        format.html {redirect_to session.delete(:return_to) || (!@contract.account_id.nil? ? account_contracts_url(@contract.account_id) : root_url(@contract.account_id)), notice: "Le contrat a été créé."}
        #if !@contract.account_id.nil?
        #  format.html  { redirect_to account_contracts_url(@contract.account_id), :notice => "Le contrat a été créé." }
        #else
        #  format.html  { redirect_to root_url(@contract.account_id), :notice => "Le contrat a été créé." }
        #end
      else
        flash[:alert] = @contract.errors.full_messages.join("\n")
        format.html  { render :action => "new" }
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
        format.html {redirect_to session.delete(:return_to) || (!@contract.account_id.nil? ? account_contracts_url(@contract.account_id) : root_url(@contract.account_id)), notice: "Le contrat a été mis à jour."}
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
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
      format.html {redirect_to session.delete(:return_to) || contracts_url }
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
