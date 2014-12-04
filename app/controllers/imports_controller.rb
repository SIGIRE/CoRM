# encoding: utf-8

##2014/11/20 - this class is used to import values from csv file to database

class ImportsController < ApplicationController
    require 'csv'
    
    #show full list of imports by paginate_by
    # GET /imports
    def index 
        @imports=Import.order('created_at')
        flash.now[:alert] = "Pas d'imports !" if @imports.empty?
        respond_to do |format|
            format.html { @imports = @imports.page(params[:page]) }  # index.html.erb
            format.json  { render :json => @imports }
        end
    end
    
    ##
  # Render a page with a form to create a new import
  #
  # GET /imports/new
  def new
    @import = Import.new
    @import.user = current_user
    @users = User.all_reals
    respond_to do |format|
        #format.html { render :template => new_import_path }# new.html.erb
        format.html { render :action => "new" }
    end
  end
  
    #form for import accounts file
    #POST /imports/new/accounts
    def accounts
        @type="accounts"
        new
    end
    
    #form for import contacts file
    #POST /imports/new/contacts
    def contacts
        @type="contacts"
        new
    end
    
    #POST /imports
    def create
             
        @type=params[:import][:import_type]       
        if @type=="accounts"
            @origin=params[:origin][:origin_id]
            @category=params[:import][:category]
        end
        @import = Import.new(params[:import])
        @import.created_by = current_user.id   
     
        respond_to do |format|
            if @import.save
                #read the file if import save succesfully                       
                #begin-end is for catching exceptions that can occurs during reading file
                begin
                    read_file(params[:file])
                end         
                #if all is ok redirect to model_controller to display the list of imported accounts
                format.html { redirect_to @models_path, method: :GET, :notice => 'L\'import a été réalisé.' }
                #format.json { render :json => @import, :status => :created, :location => @import }
            else
                flash.now[:alert] = t('app.save_undefined_error')
                format.html { render :template => new_import_path}
            end
        end
        rescue Exception => e
            #if an exception occurs during reading file, import must be destroy
            @import.destroy
            respond_to do |format|
               flash.now[:alert] = t('app.load_undefined_error')+" : "+e.message
               @origin=nil  #to avoid bug when render template
               @collegue=nil
               format.html { render :template => new_import_path }
            end
        
        
    end
    
    def destroy
        @import = Import.find(params[:id])
        
        #TODO implémenter la suppression des comptes ou contacts si aucune modification effectuée
        
        @import.destroy
        respond_to do |format|
            format.html { redirect_to imports_path, :notice => "L'import a bien été supprimé."  }
        end
    end
    
    def download
        type=params[:type]
        data = open("#{Rails.root}/app/public/#{type}/corm_import.csv") 
        send_data data.read, filename: "corm_import.csv", type: "application/txt", disposition: 'inline', stream: 'true', buffer_size: '4096' 
    end

    private
    
    #read each line of the file and create models in database
    def read_file(import_file)
        if @type=="accounts"
            #if create an account from a line failed, transaction is aborted and all
            #created accounts are rolling back
           Account.transaction do
            CSV.foreach(import_file.path, headers: true, :col_sep => ";") do |row|
                row.push({:category=>@category},
                            {:active=>true},
                            {:created_by=>current_user.id},
                            {:import_id=>@import.id},
                            {:origin_id=>@origin})
                line=Account.new row.to_hash
                line.company = line.uppercase_company
                line.web = Format.to_url(line.web)
                line.save!                                
            end
           end
           #for redirecting to the correct model template
           @models_path=accounts_path(:import_id=>@import.id)
        end
        
        if @type=="contacts"
            Contact.transaction do
                CSV.foreach(import_file.path, headers: true) do |row|
                    row.push({:created_by=>current_user.id},
                                 {:active=>true},
                                 {:import_id=>@import.id})
                    line = Contact.new row.to_hash
                    compte = Account.find_by_accounting_code((line.account_id).to_s)
                    if !compte.nil?
                        line.update_attributes(:account_id => compte.id)
                    else
                        raise "L'accounting code #{line.account_id} n'existe pas"
                    end
                    line.save!
                end
            end
            @models_path=contacts_path(:import_id=>@import.id)
        end      
    end
    
end