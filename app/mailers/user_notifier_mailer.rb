class UserNotifierMailer < ApplicationMailer
  default :from => "ninefs1006@gmail.com"

  def send_signup_email
      @greeting = "Hi"
      mail( :to => "ninefs1006@gmail.com", :subject => "会員登録が完了しました。" )
  end
end
