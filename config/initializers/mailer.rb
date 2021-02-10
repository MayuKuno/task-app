ActionMailer::Base.smtp_settings = {
  :user_name => 'your_username@kke.com', # Send Gridから送られてきているユーザ名
  :password => 'your_password', # ユーザ名に対応するパスワード
  :domain => 'yourdomain.com', # Send Grid登録時に設定した各自のドメイン名
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}