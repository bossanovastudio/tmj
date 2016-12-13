class UsersMailer < ApplicationMailer
    default from: '"TMJ" <noreply@tmjofilme.com.br>'

    def welcome(user)
      @user = user
      mail(to: @user.email, subject: 'Bem-vindo ao TMJ!')
    end
end
