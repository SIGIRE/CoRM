# encoding: utf-8


class OpportunitiesController < ApplicationController
  load_and_authorize_resource :account
  load_and_authorize_resource :opportunity, :through => :account
  

  before_filter :authenticate_user!
  before_filter :load_account, :load_settings, only: [:index]
  layout :current_layout

  has_scope :by_user_id
  has_scope :by_author_user_id
  has_scope :by_statut
  has_scope :by_account_company_like
  has_scope :by_account_tags, as: :account_tag
  has_scope :by_origin_account, as: :account_origin
  has_scope :by_zip_account, as: :account_zip
  has_scope :by_activity_account, as: :account_activity



  ##
  # Display the full list of Opportunities by paginate_by
  #
  def index
    default_order = 'term'
    default_direction = 'DESC'
    @sort = params[:sort] || default_order
    @direction = params[:direction] || default_direction

    @opportunities_all = apply_scopes(opportunities).
                     order("#{@sort} #{@direction}")

    @opportunities = @opportunities_all.page(params[:page])

    @opportunities_scopes = current_scopes


    #initialisation puis calcul des totaux
    @total_amount = 0
    @total_profit = 0
    @opportunities_all.each do |op|
      @total_amount += op.amount
      @total_profit += op.profit
    end

    flash.now[:alert] = "Pas d'opportunités !" if @opportunities.empty?

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx # index.xlsx.axlsx
    end
  end

  ##
  # Display one occurence of Opportunity
  #
  def show
    @opportunity = Opportunity.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @opportunity }
    end
  end

  ##
  # Redner the page to create a new Opportunity
  #
  def new
    @opportunity = Opportunity.new
    @opportunity.user = current_user
    @opportunity.account_id = params[:account_id]

    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @opportunity }
    end
  end

  ##
  # Process to save a new Opportunity
  #
  def create
    params[:opportunity][:profit] = params[:opportunity][:profit].gsub(' ', '')
    params[:opportunity][:amount] = params[:opportunity][:amount].gsub(' ', '')
    @opportunity = Opportunity.new(params[:opportunity])
    @opportunity.created_by = current_user.id
    @opportunity.amount ||= 0
    @opportunity.profit ||= 0

    respond_to do |format|
      if @opportunity.save
        if params[:mail] == 'yes'
          UserMailer.mail_for(@opportunity.user, @opportunity, true).deliver
        end
        self.create_event(false)
        format.html { redirect_to session.delete(:return_to) , notice: "L'opportunité a été créée." }
      else
        flash[:alert] = @opportunity.errors.full_messages.join("\n")
        format.html  { render :action => "new" }
      end
    end
  end

  ##
  # Render the page to edit an Opportunity
  #
  def edit
    @opportunity = Opportunity.find(params[:id])
    @users = User.all_reals
  end

  ##
  # Process to save an existing Opportunity
  #
  def update
    params[:opportunity][:profit] = params[:opportunity][:profit].gsub(' ', '')
    params[:opportunity][:amount] = params[:opportunity][:amount].gsub(' ', '')
    
    @opportunity = Opportunity.find(params[:id])
    @opportunity_before_update = Opportunity.find(params[:id])
    @opportunity.updated_by = current_user.id

    if params[:opportunity][:amount].blank?
      params[:opportunity][:amount] = 0
    end

    if params[:opportunity][:profit].blank?
      params[:opportunity][:profit] = 0
    end

    respond_to do |format|
      if @opportunity.update_attributes(params[:opportunity])
        if params[:mail] == 'yes'
          UserMailer.mail_for(@opportunity.user, @opportunity, true).deliver
        end
        if !(@opportunity.statut == @opportunity_before_update.statut)
          self.create_event(true)
        end
        format.html { redirect_to session.delete(:return_to), notice: "L'opportunité a été mise à jour." }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end

  ##
  # Process to remove an existing opportunity from the database
  #
  def destroy
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy

    respond_to do |format|
      #format.html { redirect_to (!@opportunity.account.nil? ? account_events_path(@opportunity.account) : opportunities_url), :notice => "L'opportunité a bien été supprimée."  }*
      format.html { redirect_to session.delete(:return_to), notice: "L'opportunité a bien été supprimée." }
    end
  end

  ##
  # Render a part of Contacts by Account
  #
  def update_contact_select
    contacts = Contact.where(:account_id => params[:id]).order(:surname)
    render :partial => "contacts" , :locals =>{:contacts => contacts }
  end


  ##
  # Create an Event from an Opportunity.
  # * *Args*    :
  #   - +updated+ -> if the object is updated(true) or created(false)

  def create_event(updated)
    # Si le paramètre envoyé est false, 'type' = :create, sinon :update
    type = updated ? :update : :create
    if can? type, Event
      hash = Hash.new
      hash["account_id"] = params[:opportunity][:account_id]
      hash["contact_id"] = params[:opportunity][:contact_id]
      hash["date_begin"] = Time.now
      hash["date_end"] = hash["date_begin"]
      hash["notes2"] = params[:opportunity][:description]
      # to test
      if(updated == true)
        hash["modified_by"] = current_user.id
        hash["notes"] = 'Opportunité "' + params[:opportunity][:name] + '" modifiée. Le statut est passé de "' + @opportunity_before_update.statut + '" à "' + params[:opportunity][:statut] + '".'
      else
        hash["created_by"] = current_user.id
        hash["notes"] = 'Opportunité "' + params[:opportunity][:name] + '" créée avec statut "' + params[:opportunity][:statut] + '".'
      end

      hash["opportunity_id"] = @opportunity.id
      @event = Event.create(hash)
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

    def opportunities
      @account ? @account.opportunities : Opportunity
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end
end
