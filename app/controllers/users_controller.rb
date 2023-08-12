class UsersController < ApplicationController
  def api_token
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: @user.api_token, status: :ok }
      format.html {}
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) || not_found
  end
end
