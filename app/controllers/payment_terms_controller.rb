# encoding: utf-8

##
# The Controller that manage PaymentTerms
#
class PaymentTermsController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all PaymentTerms by paginate_by
  #
  # GET /payment_terms
  def index
    @payment_terms = PaymentTerm.order('name').page(params[:page])

    respond_to do |format|
      format.html  # index.html.erb
    end
  end

  ##
  # Render a page to create new PaymentTerm
  #
  def new
    @payment_term = PaymentTerm.new

    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  ##
  # Process to insert a new PaymentTerm into the DataBase
  #
  def create
    @payment_term = PaymentTerm.new(params[:payment_term])
    @payment_term.created_by = current_user.id

    respond_to do |format|
      if @payment_term.save
        format.html  { redirect_to payment_terms_path, :notice => t('app.message.notice.created_payment_term') }
      else
        format.html  { render :action => "new" }
      end
    end
  end


  def edit
    @payment_term = PaymentTerm.find(params[:id])
  end

  ##
  # Process that udpate an existing PaymentTerm
  #
  def update
    @payment_term = PaymentTerm.find(params[:id])
    @payment_term.modified_by = current_user.id

    respond_to do |format|
      if @payment_term.update_attributes(params[:payment_term])
        format.html  { redirect_to(payment_terms_url, :notice => t('app.message.notice.updated_payment_term')) }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end

  ##
  # Process that remove an PaymentTerm from the DB
  #
  def destroy
    @payment_term = PaymentTerm.find(params[:id])
    respond_to do |format|
      if @payment_term.destroy
        format.html  { redirect_to(payment_terms_url, :notice => t('app.message.notice.deleted_payment_term')) }
      else
        flash[:error] = t('app.delete_undefined_error')
        format.html  { render :action => "edit" }      
      end
    end
  end

end
