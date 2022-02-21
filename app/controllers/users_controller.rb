class UsersController < ApplicationController

  def index; end

  def import_users
    @users = User.import(params[:file])
    render :index
  end
end
