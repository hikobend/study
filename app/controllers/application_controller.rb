
class ApplicationController < ActionController::Base
    # ユーザーがページにアクセスする前に実行する
    before_action :configure_permitted_parameters, if: :devise_controller?

    # このControllerの中でしか呼び出さない
    private
    # sign_upの時にusernameを許可する
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end