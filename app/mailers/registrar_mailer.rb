class RegistrarMailer < ApplicationMailer
  def registration_confirmed_email(user)
    @user = user
    mail(
      to: REGISTRAR_EMAIL,
      subject: "[EBSSL] User #{@user.name}'s manager approved his application."
    )
  end
end
