module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
 
  # 現在ログインしているユーザーを返す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # @current_userに何も代入されていない時だけfind_byを呼び出して変数に格納することで、
    # 同じユーザーから複数回このメソッドを呼び出さた際に、都度DBに問い合わせる必要がなくなる。
    # 始めは当然@current_userはnilなので、セッション情報に含まれるuser_idに紐づくUserオブジェクトを抽出し、変数に代入するという処理が行われる
  end
 



  def logged_in?
    !current_user.nil?
    # ログイン中の状態＝セッションにユーザーが存在する＝current_userがnilでない状態。
  end
end
