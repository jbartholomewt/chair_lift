class Api::LiftsController < ApiController
  def index
    lifts = Lift.search(params[:query])
    render json: { lifts: lifts }, status: :ok
  end
end
