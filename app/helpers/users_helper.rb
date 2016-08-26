require 'open-uri'

module UsersHelper
end

class RegistrationPdf < Prawn::Document
  def initialize(user, view)
    info = {page_size: "A4", page_layout: :portrait, margin: 10}
    super(info)
    image "#{Rails.root}/app/assets/images/reg_form_top.png", height: 90, width: 725
    move_to 100, 100
    text "First Name: #{user.first_name}"
    text "Middle Name: #{user.middle_name}"
    text "Last Name: #{user.last_name}"
    text "Email: #{user.email}"
    text "Date Of Birth: #{user.dob.strftime('%b %d, %Y')}"
    text "Day Phone: #{user.day_phone}"
    text "Evening Phone: #{user.evening_phone}"
    text user.license_or_passport
    text "Have you played in this league before? #{user.league_played_before ? 'Yes' : 'No'}"
    if user.league_played_before
      text "What season? #{user.league_past_when}"
      text "Team name? #{user.league_past_team_name}"
      text "Your name? #{user.league_past_your_name}"
    end
    if team = user.player.team
      text "Team: #{team.name}"
      if user.manager_confirmation
        text "Confirmed by team manager: #{team.manager.name}"
        text "Team Manager Signature: #{user.manager_signature} on #{user.manager_signature_date.strftime('%b %d, %Y')}"
      else  
        text "NOT YET Confirmed by team manager #{team.manager.name}"
      end
    end
    start_new_page
    image open(user.photo.url), height: 108
    image open(user.photo.url), height: 108
    image open(user.license_photo.url), height: 144
    image open(user.license_photo.url), height: 144
  end
end
