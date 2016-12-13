class UsersMailer < ApplicationMailer
    default from: '"TMJ" <noreply@tmjofilme.com.br>'
    layout false
    def welcome(user)
      @user = user
      mail(to: @user.email, subject: 'Bem-vindo ao TMJ!')
    end
end
