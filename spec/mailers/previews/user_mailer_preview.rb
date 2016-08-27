# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def invited_welcome_mail_preview
    UserMailer.welcome_email({user: User.last, invited: true})
  end

  def uninvited_welcome_mail_preview
    UserMailer.welcome_email({user: User.last, invited: false})
  end
end
