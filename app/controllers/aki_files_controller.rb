class AkiFilesController < ApplicationController
  before_action :set_user
  before_action :set_user_aki_file, only: [:show, :update, :destroy]

  # POST /users/:user_id/files
  def create
    @user.aki_files.create!(aki_file_params)
    json_response(@user, :created)
  end

  # GET /users/:user_id/files/:id
  def show
    json_response(@aki_file)
  end

  # PUT /users/:user_id/files/:id
  def update
    @aki_file.update(aki_file_params)
    head :no_content
  end

  # DELETE /users/:user_id/files/:id
  def destroy
    @aki_file.destroy
    head :no_content
  end

  private

  def aki_file_params
    params.permit(:filename, :contents)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_aki_file
    @aki_file = @user.aki_files.find_by!(id: params[:id]) if @user
  end
end
