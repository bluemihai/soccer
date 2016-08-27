class UserMailer < ApplicationMailer

  def welcome_email(args)
    @user = args[:user]
    @invited = args[:invited]
    mail(to: @user.email, subject: "Welcome to #{LEAGUE_NAME_SHORT}, #{@user.first}!")
  end
end
