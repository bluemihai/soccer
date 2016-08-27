# Preview all emails at http://localhost:3000/rails/mailers/manager
class ManagerMailerPreview < ActionMailer::Preview
  def user_updated_mail_preview
    ManagerMailer.user_updated_email(User.last)
  end
end
