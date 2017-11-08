class UsersController < ApplicationController
  skip_before_action :require_login
  def login
  end
end
