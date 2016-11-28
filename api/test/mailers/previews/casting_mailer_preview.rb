# Preview all emails at http://localhost:3000/rails/mailers/casting_mailer
class CastingMailerPreview < ActionMailer::Preview
  def register_successful
    CastingMailer.register_successful(Casting.first)
  end
end
