class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:index]

  def index
    render json: current_user, status: :ok
  end

  def traders
    users = User.all.where(role: 'trader', approved: true)
    render json: users
  end

  def trader
    user = User.find(params[:id])
    render json: user
  end
  
  def pending
    users = User.all.where(approved: 'false')
    render json: users
  end

  def create
    user = User.create(user_params)
    user.update!(approved: true)
    user.confirm

    render json: json = {
      status: 201, 
      message: 'User registered!',
      trader: user
    }, status: :ok
  end

  def approve_user
    user = User.find(params[:id])
    user.update!(approved: true)

    render json: json = {
      status: 201, 
      message: 'User approved!',
      trader: user
    }, status: :ok
  end


  private

  def user_params 
    params.require(:user).permit(:email, :password)
  end

  def authenticate_admin
    render json: json = {
      status: 401, 
      message: 'Unauthorized user.',
    }, status: :unauthorized unless current_user.role == 'admin'
  end
end