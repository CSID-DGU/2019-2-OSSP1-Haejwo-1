class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def kakao
    auth_login('kakao')
  end

  def naver
    auth_login('naver')
  end

  def facebook
    auth_login('facebook')
  end

  def after_sign_in_path_for(resource)
    auth = request.env['omniauth.auth']
    @identity = Identity.find_for_oauth(auth)
    if current_user.persisted?
      root_path
    else
      new_user_registration_path
    end
  end

  private
  def auth_login(provider)
    sns_login = SnsLogin.new(request.env["omniauth.auth"], current_user)
    @user = sns_login.find_user_oauth

    if @user.persisted?
      sign_in @user
      will_redirect_path = @user.sign_in_count.zero? ? edit_user_registration_path : root_path
      redirect_to will_redirect_path, notice: "성공적으로 가입되었습니다."
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, notice: '로그인 에러가 발생하였습니다.'
    end
  end
end
