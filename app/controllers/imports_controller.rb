# encoding: utf-8

##2014/11/20 - this class is used to import values from csv file to database

class ImportsController < ApplicationController
    
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
        @import = Import.new
        @import.user = current_user
        @users = User.all_reals
        @type="comptes"
        respond_to do |format|
            format.html { render :template => new_import_path }# new.html.erb
            #format.json { render :json => @account }
        end
    end
    
    #form for import contacts file
    #POST /imports/new/contacts
    def contacts
        @import = Import.new
        @import.user = current_user
        @users = User.all_reals
        @type="contacts"
        respond_to do |format|
            format.html { render :template => new_import_path }# new.html.erb
            #format.json { render :json => @account }
        end
    end
    
    def read
        #code
    end
    
    def destroy
        @import = Import.find(params[:id])
        
        #TODO implémenter la suppression des comptes ou contacts si aucune modification effectuée
        
        @import.destroy
        respond_to do |format|
            format.html { redirect_to root_path, :notice => "L'import a bien été supprimé."  }
            format.json { head :no_content }
        end
    end
    
    
        
end
