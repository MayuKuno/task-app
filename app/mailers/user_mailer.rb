class UserMailer < ApplicationMailer
  default :from => "ninefs1006@gmail.com"

  def remainder(user)
    @user = user
    mail( :to => @user.email, # 送信先アドレスの指定
          :subject => '期日が近いタスクがあります。'  # 送信メールの件名
        )
  end

  def password_reset(user)
    @user = user
    mail( :to => @user.email, # 送信先アドレスの指定
    :subject => 'Password reset'  # 送信メールの件名
  )
  end

end
