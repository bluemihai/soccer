class ManagerMailer < ApplicationMailer
  def user_updated_email(user)
    @user = user
    mail(
      to: @user.manager.email,
      subject: "[EBSSL] Your player #{@user.name} has updated his user profile."
    )
  end
end
