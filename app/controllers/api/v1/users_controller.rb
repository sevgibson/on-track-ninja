class Api::V1::UsersController < Api::V1::ApiController

  #caches :index, :show, :cache_for => 5.minutes

  def index
    users = User.where("id is not null").paginate(:page => params[:page])
#    expose users.paginate(:page => params[:page]), serializer: 
#    ActiveModel::ArraySerializer.root = false
#    render ActiveModel::ArraySerializer.new(users, each_serializer: UserSerializer)
    render json: users, each_serializer: UserSerializer
  end

  def show
    respond_with User.find(params[:id]), serializer: UserSerializer
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, :v1, user], serializer: UserSerializer
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200, location: [:api, :v1, user], serializer: UserSerializer
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
