class CastingMailer < ApplicationMailer
  default from: '"TMJ - Participe" <casting@tmjofilme.com.br>'

    def register_successful(casting)
      @casting = casting
      mail(to: @casting.adult_email, subject: 'Inscrição realizada com sucesso.')
    end
end
