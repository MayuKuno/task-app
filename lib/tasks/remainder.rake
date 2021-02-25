namespace :greeting do
  desc 'remainder/リマインドのメールをする'
  task :remainder => :environment do
    users = User.all
    today = Date.today

    users.each do |user|
      user.tasks.each do |task|
        if task.notification.present? && today + 1 == task.deadline.to_date
          UserMailer.remainder(user).deliver
        end
      end
    end
  end
end