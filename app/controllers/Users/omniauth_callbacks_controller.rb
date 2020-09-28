# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def twitter
     @user = User.from_omniauth(request.env["omniauth.auth"])
    # binding.pry
    if @user.persisted?
      #binding.pry
      @user.skip_confirmation!
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      #sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      #session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      # ↑ 認証データを覚える必要はないので削除
      #redirect_to new_user_registration_url
      @user.skip_confirmation!
      @user.save!
      # redirect_to new_user_registration_url
      # ↑ ログインすることになるので以下のように修正
      sign_in_and_redirect @user
    end
  end
  def after_sign_in_path_for(resource)
      #リダイレクトしたいパス
      #'/users/o_auth/twitter/success'
      if params[:origin_callback_url] != nil
          params[:origin_callback_url]
      else
        "/users/show/#{@user.id}"
      end
  end
  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  def passthru
    super
  end

  # GET|POST /users/auth/twitter/callback
   def failure
     redirect_to root_path
   end

   protected

  # The path used when OmniAuth fails
   def after_omniauth_failure_path_for(scope)
     super(scope)
   end
end
