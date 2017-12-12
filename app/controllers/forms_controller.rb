class FormsController < ApplicationController

  before_action :set_form, only: [:destroy, :show]

  before_action :authenticate_admin!, except: [:new, :create]


  def index

    @filterrific = initialize_filterrific(
        Form,
        params[:filterrific],
        select_options: {
            sorted_by: Form.options_for_sorted_by
        },
        persistence_id: 'shared_key',
        default_filter_params: {},
    ) or return
    @forms = @filterrific.find.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

    #@forms = Form.paginate(:page => params[:page], :per_page => 50)
  end


  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @form }
        flash[:success] = "You've successfully applied for the #{@form.position} position. We will be in touch with you via mail on your application status. Thank You."
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end


  def show
  end

  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to forms_url, notice: 'Application successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_form
    @form = Form.friendly.find(params[:id])
  end


  def form_params
    params.require(:form).permit(:name, :address, :email, :dob, :reference, :position, :mobile_number, :document, :linkedin_url)
  end
end
