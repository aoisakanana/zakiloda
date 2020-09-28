class PagesController < ApplicationController
  def index
    if user_signed_in? then
      @user = current_user
    else
      @user = nil
    end
  end
end
