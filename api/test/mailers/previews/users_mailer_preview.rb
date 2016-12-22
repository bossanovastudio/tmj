# Preview all emails at http://localhost:3000/rails/mailers/users_mailer
class UsersMailerPreview < ActionMailer::Preview
  def welcome
    UsersMailer.welcome(User.first)
  end
end
