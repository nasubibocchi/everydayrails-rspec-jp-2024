class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_app, only: :index

  def index
    puts "Before actions: #{self.class._process_action_callbacks}"
    @users = User.order(:updated_at).limit(5)
    render json: @users 
  end

  private

  def authenticate_app
    api_key_header = request.headers["Api-Key"] # テストの練習のためなので存在すればOK
    render json: { status: "auth failed" } unless api_key_header
  end
end

