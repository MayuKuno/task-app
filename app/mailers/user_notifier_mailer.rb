class UserNotifierMailer < ApplicationMailer
  default :from => 'notify@yourdomain' # 送信元アドレスの指定

  # サインアップ時（ユーザ新規登録時）にメール送信するためのアクション
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email, # 送信先アドレスの指定
          :subject => 'ご登録ありがとうございます！'  # 送信メールの件名
        )
  end
end
