class TontinesController < ApplicationController
  before_action :set_tontine, only: %i[edit show destroy update]

  def index
    @tontines = Tontine.all
  end

  def show
  end

  def new
    @tontine = Tontine.new
  end

  def create
    @tontine = Tontine.new(params_tontine)
    @tontine.id = Tontine.maximum(:id).next.to_i
    @tontine.user = current_user
    @tontine.status = "pending"

    if @tontine.save!
      redirect_to edit_tontine_path(@tontine)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @tontine.update(params_tontine)
    redirect_to tontine_path(@tontine)
  end

  def destroy
    @tontine.update(params_tontine)
    redirect_to tontines_path, status: :see_other
  end

  private

  def set_tontine
    @tontine = Tontine.find(params[:id])
  end

  def params_tontine
    params.require(:tontine).permit(:name, :contribution, :start_month, :payment_day, :participants)
  end
end
