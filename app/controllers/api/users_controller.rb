class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[ update destroy ]

  # GET /users
  def index
    @users = User.page(params[:page]).per(8)

    render json: {
      users: @users,
      total_pages: @users.total_pages
    }
  end

  # POST /users
  def create    
    @user = User.new(user_params)

    if @user.save
      render json: "Usuario creado con éxito !", status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: "Usuario editado con éxito !"
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy!
      render json: "Usario eliminado con éxito !"
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def users_length
    render json: User.count
  end

  private
    def set_user
      begin
        @user = User.find params[:id]

      rescue ActiveRecord::RecordNotFound => e
        render json: "No pudo ser encontrado usuario con ID -> #{params[:id]}", status: :not_found
      end
    end

    def user_params
      params.require(:user).permit(:name, :last_name, :email, :phone, :gender, :address)
    end
end
