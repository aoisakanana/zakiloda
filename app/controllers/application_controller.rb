class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    def after_sign_in_path_for(resource)
        #ログインしたら、ユーザページへ
        if params[:origin_callback_url] != nil
          params[:origin_callback_url]
        else
          "/users/show/#{current_user.id}"
        end
    end
    class Forbidden < ActionController::ActionControllerError
    end
    rescue_from Forbidden, with: :rescue403
    private 
    def sign_in_required
        if params[:origin_callback_url] != nil
          @url = new_user_session_url + params[:origin_callback_url]
        else
          @url = new_user_session_url
        end
        #ログインしていない場合はログイン画面へリダイレクト
        redirect_to @url unless user_signed_in?
    end
    def rescue403(e)
      @exception = e
      #app/errors/forbbiden.html.erb を表示します
      render template: 'errors/forbidden', status: 403
    end
    protected 
    def configure_permitted_parameters
        #ストロングパラメータ。アクションに対して、下記カラムの変更を許可します
      devise_parameter_sanitizer.permit(:sign_up,keys: [:uid,:username,:name,:provider])
      devise_parameter_sanitizer.permit(:account_update, keys: [:uid,:username,:name,:provider])
    end
end
