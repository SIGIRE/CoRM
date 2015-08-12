# encoding: utf-8

##
# The Controller that manage PaymentModes
#
class PaymentModesController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all PaymentModes by paginate_by
  #
  # GET /payment_modes
  def index
    @payment_modes = PaymentMode.order('name').page(params[:page])

    respond_to do |format|
      format.html  # index.html.erb
    end
  end

  ##
  # Render a page to create new PaymentMode
  #
  def new
    @payment_mode = PaymentMode.new

    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  ##
  # Process to insert a new PaymentMode into the DataBase
  #
  def create
    @payment_mode = PaymentMode.new(params[:payment_mode])
    @payment_mode.created_by = current_user.id

    respond_to do |format|
      if @payment_mode.save
        format.html  { redirect_to payment_modes_path, :notice => t('app.message.notice.created_payment_mode') }
      else
        format.html  { render :action => "new" }
      end
    end
  end


  def edit
    @payment_mode = PaymentMode.find(params[:id])
  end

  ##
  # Process that udpate an existing PaymentMode
  #
  def update
    @payment_mode = PaymentMode.find(params[:id])
    @payment_mode.modified_by = current_user.id

    respond_to do |format|
      if @payment_mode.update_attributes(params[:payment_mode])
        format.html  { redirect_to(payment_modes_url, :notice => t('app.message.notice.updated_payment_mode')) }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end

  ##
  # Process that remove an PaymentMode from the DB
  #
  def destroy
    @payment_mode = PaymentMode.find(params[:id])
    respond_to do |format|
      if @payment_mode.destroy
        format.html  { redirect_to(payment_modes_url, :notice => t('app.message.notice.deleted_payment_mode')) }
      else
        flash[:error] = t('app.delete_undefined_error')
        format.html  { render :action => "edit" }      
      end
    end
  end

end
