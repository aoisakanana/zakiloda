# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]
  before_action :get_origin_callback_url, only: [:new,:create,:destroy]
  def get_origin_callback_url
    @origin_callback_url = params[:origin_callback_url]
  end
  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
     #binding.pry
     super
   end

  # DELETE /resource/sign_out
   def destroy
     super
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     #devise_parameter_sanitizer.permit(:sign_in, keys: [:origin_callback_url])
   end
end
