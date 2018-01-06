module SessionsHelper
  # ログイン中のユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーがログインしてるか
  def logged_in?
    !current_user.nil?
  end

end
