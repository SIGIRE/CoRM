
##2014/11/20 - this class is used to import values from csv file to database

class ImportController < ApplicationController
    
    def import
        #Model concern by the csv file
        session[:model]=params[:model]
        if session[:model]=="Account"
            @key_word=t('app.controllers.Account').pluralize
        end
        
    end
    
    def upload
        #call import method for the concerned model (model type store in session variable)
        Object.const_get(session[:model]).import(params[:file])
        redirect_to accounts_path
    end
    
end
