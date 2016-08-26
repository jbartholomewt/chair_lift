class LiftsController < ApplicationController
  before_action :authenticate_user!
  def index
    @lifts = Lift.search(params[:query])
    @partial = params[:view] || "map" || "list"
  end

  def create
    @lift = Lift.new(params_lift)
    @lift.user = current_user
    if @lift.save
      flash[:notice] = 'Lift successfully added!'
      redirect_to lifts_path(@lift)
    else
      flash[:error] = @lift.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    @lift = Lift.find(params[:id])
    if @lift.update(params_lift)
      flash[:success] = 'lift successfully updated'
      redirect_to lift_path(@lift)
    else
      flash[:errors] = @lift.errors.full_messages.join(', ')
      render :edit
    end
  end

  def new
    @lift = Lift.new
  end

  def show
    @lift = Lift.find(params[:id])
    @user = @lift.user
  end

  def edit
    @lift = Lift.find(params[:id])
  end

  def destroy
    @lift = Lift.find(params[:id])
    @lift.destroy
    redirect_to lifts_path
  end

  private

  def params_lift
    params.require(:lift).permit(:name, :departure, :destination, :zip, :description, :open_seats, :departure_date)
  end
end
