class Api::V1::MentorShip < Api::V1::ApiController

  def index
    render json: User.all
  end

end
