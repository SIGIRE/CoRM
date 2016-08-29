# encoding: utf-8

##
# The Controller that manage Account's categories
#
class AccountCategoriesController < ApplicationController
  
  load_and_authorize_resource

  ##
  # Display the list of all AccountCategories by paginate_by
  #
  # GET /account_categories
  def index
    @account_categories = AccountCategory.order('name').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  #
  ## Render a page to create new AccountCategory
  #
  # GET /account_categories/new
  def new
    @account_category = AccountCategory.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  #
  ## Render a page to update an AccountCategory
  #
  # GET /account_categories/1/edit
  def edit
    @account_category = AccountCategory.find(params[:id])
  end

  #
  ## Create a new AccountCategory
  #
  # POST /account_categories
  def create
    @account_category = AccountCategory.new(params[:account_category])
    @account_category.created_by = current_user.id

    respond_to do |format|
      if @account_category.save
        format.html { redirect_to account_categories_path, notice: "#{t('app/messages.notice.created_account_category')}" }
      else
        format.html { render action: "new" }
      end
    end
  end

  #
  ## Update an existing AccountCategory
  #
  # PUT /account_categories/1
  def update
    @account_category = AccountCategory.find(params[:id])
    @account_category.updated_by = current_user.id
    
    respond_to do |format|
      if @account_category.update_attributes(params[:account_category])
        format.html { redirect_to @account_categories_url, notice: "#{t('app/messages.notice.updated_account_category')}" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  #
  ## Delete an existing AccountCategory
  #
  # DELETE /account_categories/1
  def destroy
    @account_category = AccountCategory.find(params[:id])
    @account_category.destroy

    respond_to do |format|
      format.html { redirect_to account_categories_url, notice: "#{t('app/messages.notice.deleted_account_category')}"  }
    end
  end
end
