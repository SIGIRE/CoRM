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
  # GET /imports/new.json
  def new
    
  end
  
    #form for import accounts file
    #POST /imports/new/accounts
    def accounts
        init
        @type="accounts"
        respond_to do |format|
            format.html { render :template => new_import_path }# new.html.erb
        end
    end
    
    #form for import contacts file
    #POST /imports/new/contacts
    def contacts
        init
        @type="contacts"
        respond_to do |format|
            format.html { render :template => new_import_path }# new.html.erb
        end
    end
    
    def create
        @import = Import.new(params[:import])
        @import.created_by = current_user.id
        @category=params[:import][:categorie]
        @type=params[:import][:import_type]
        
      
        respond_to do |format|
            if @import.save
                #read the file if import save        
                if !params[:file].nil?
                    read_file(params[:file])
                end
                format.html { redirect_to imports_path, :notice => 'L\'import a été réalisé.' }
                #format.json { render :json => @import, :status => :created, :location => @import }
            else
                flash[:error] = t('app.save_undefined_error')
                format.html { render :template => new_import_path }
            end
        end
        rescue Exception => e
            #if an exception occur during reading file and create accounts, import is deleted
            @import.destroy
            respond_to do |format|
               format.html { render :template => new_import_path, :alert => "Erreur de chargement du fichier ! #{e.message}"}
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
    
    private
    def init
        @import = Import.new
        @import.user = current_user
        @users = User.all_reals
    end
    
    def read_file(import_file)
        if @type=="accounts"
            #all accounts are created or not
           Account.transaction do
            CSV.foreach(import_file.path, headers: true) do |row|
                row.push({:category=>@category},{:active=>true},{:created_by=>current_user.id})
                @line=Account.new row.to_hash
                @line.company = @line.uppercase_company
                @line.web = to_url(@line.web)
                @line.import_id=@import.id
                if !@line.save
                    raise ExceptionType, "Une ou plusieurs lignes du fichier sont incorrectes !"
                end                
            end
           end 
        end
      
    end
    
    def to_url(url)
        if !url.nil? and url.length > 0
            correction = nil
            # dont start with protocol://
            if url[/^*:\/\//] == nil
                correction = 'http://'
                # if it is somthing like lang.website.tld
                if url[/^www[.]/] == nil and url[/^.*.[.].*.[.].*.$/] == nil
                    correction.concat('www.')
                end
            end
        end
    return (!correction.nil?() ? correction.concat(url) : url)
    end
    
end
