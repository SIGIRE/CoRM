# encoding: utf-8

##2014/11/20 - this class is used to import values from csv file to database

class ImportsController < ApplicationController

    #show full list of imports by paginate_by
    # GET /imports
    def index
        @imports=Import.order('created_at')
        flash.now[:alert] = "#{t('app.message.alert.no_import')}" if @imports.empty?
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
        end
        @import = Import.new(params[:import])
        @import.created_by = current_user.id

        respond_to do |format|
            if @import.save
                #read the file if import save succesfully

                read_file(params[:file])

                #if all is ok redirect to model_controller to display the list of imported accounts
                format.html { redirect_to @models_path, method: :GET, :notice => "#{t('app.message.notice.import_done')}" }
                #format.json { render :json => @import, :status => :created, :location => @import }
            else
                flash.now[:alert] = t('app.save_undefined_error')
                format.html { render :template => new_import_path}
            end
        end
        #rescue Exception => e
        #    #if an exception occurs during reading file, import must be destroy
        #    @import.destroy
        #    respond_to do |format|
        #       flash.now[:alert] = t('app.load_undefined_error')+" #{@num_line} : "+e.message
        #       @origin=nil  #to avoid bug when render template
        #       @collegue=nil
        #       format.html { render :template => new_import_path }
        #    end

    end

    def destroy
        @import = Import.find(params[:id])
        #delete accounts or contacts associated with delete import are implemented in import_model
        #with dependent in has_many
        @import.destroy
        respond_to do |format|
            format.html { redirect_to imports_path, :notice => "#{t('app.message.notice.delete_import')}"  }
        end
    end

    def download
        type=params[:type]
        data = open("#{Rails.root}/app/public/model_import_file/corm_import_#{type}.csv")
        send_data data.read, filename: "corm_import_#{type}.csv", type: "application/txt", disposition: 'inline', stream: 'true', buffer_size: '4096'
    end

    private

    #read each line of the file and create models in database
    def read_file(import_file)
        @num_line=1
        if @type=="accounts"
            #if create an account from a line failed, transaction is aborted and all
            #created accounts are rolling back
           ImportAccount.transaction do
            CSV.foreach(import_file.path, headers: true, :header_converters => :symbol, :col_sep => ";") do |row|
                row.push(   {:active=>true},
                            {:created_by=>current_user.id},
                            {:import_id=>@import.id},
                            {:origin_id=>@origin})
                line=ImportAccount.new row.to_hash
                if !line.company.nil?
                    line.company = line.uppercase_company
                end
                line.web = Format.to_url(line.web)
                if !line.category.nil?
                    line.category = line.category.capitalize
                end
                line.save!
                @num_line+=1

                #check datas
                line.check
            end
           end
           #for redirecting to the correct model template
           @models_path=import_accounts_path
        end

        if @type=="contacts"
            Contact.transaction do
                CSV.foreach(import_file.path, headers: true, :header_converters => :symbol, :col_sep => ";") do |row|
                    row.push({:created_by=>current_user.id},
                                 {:active=>true},
                                 {:import_id=>@import.id})
                    line = ImportContact.new(row.to_hash)
                    line.save!
                    @num_line+=1

                    #check datas
                    line.check

                end
            end
            @models_path=import_contacts_path
        end
    end

end
