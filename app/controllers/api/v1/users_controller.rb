class Api::V1::UsersController < Api::V1::ApiController

  class UserSerializer < ActiveModel::Serializer
#    cache key: 'users', expires_in: 3.hours
    attributes :id, :name, :created_at, :updated_at
#    url :user
  end

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
end
