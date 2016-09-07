require 'open-uri'

module UsersHelper
end

class RegistrationPdf < Prawn::Document
  def initialize(user, view)
    info = {page_size: "A4", page_layout: :portrait, margin: 10}
    super(info)
    bounding_box([20, 800], width: 700, height: 50) do
      font 'Helvetica', size: 20, styles: [:bold]
      text 'East Bay Senior Soccer League — Player Pass Application'      
      font 'Helvetica', size: 12, styles: [:normal]
    end
    bounding_box([300, 750], width: 300, height: 200) do
      image open(user.license_photo.url), height: 200, width: 300
    end
    bounding_box([20, 750], width: 100, height: 250) do
      text "First Name"
      text "Middle Name"
      text "Last Name"
      text "Email"
      text "Date Of Birth"
      text "Day Phone"
      text "Evening Phone"
      text user.dl_license_no.blank? ? 'Passport' : 'Drivers License'
      if user.league_played_before
        text ' '
        text ' '
        text 'EBSSL History?'
        text ' '
      else
        text 'EBSSL History?'
      end
    end
    bounding_box([120, 750], width: 180, height: 250) do
      text user.first_name
      text (user.middle_name.blank? ? ' ' : user.middle_name)
      text user.last_name
      text user.email
      text user.dob.strftime('%b %d, %Y')
      text user.day_phone_formatted
      text user.evening_phone_formatted
      text user.license_or_passport_number_only
      if user.league_played_before
        text ' '
        text "#{user.league_past_when}"
        text "#{user.league_past_team_name}"
        text "as #{user.league_past_your_name}"
      else
        text 'None'
      end
    end
    bounding_box([450, 500], width: 150, height: 200) do
      image open(user.photo.url), width: 108, height: 108
    end
    bounding_box([20, 500], width: 430, height: 450) do
      stroke_color "000000"
      font 'Helvetica', style: :bold
      text 'Liability Waiver, Certification, and Authorization to Verify Records'
      text ' '
      font 'Helvetica', style: :normal
      text "I, #{user.name}, as a player in the East Bay Senior Soccer League, understand that I play in this League at my own risk, and that the League does not provide insurance coverage in the event that I become injured as a result of my direct or indirect participation in the League. I hold the League and its officials harmless in the event of such occurrence."
      text ' '
      text 'I certify that all of the above information is true and correct, that the attached photocopy of my driver license (and/or passport) is a true copy of the original document without alterations and that the enclosed photographs signed by me are true photographs of myself.'
      text ' '
      text 'I authorize the State of California Department of Motor Vehicles or any other applicable agency to disclose my date of birth to any EBSSL League officer carrying this form, for the sole purpose of determining my eligibility to play in the EBSSL League.'
      text ' '
      formatted_text [
        { text: 'Signed:   ' },
        { text: user.name, styles: [:italic] },
        { text: '     '},
        { text: user.created_at.strftime('%b %d, %Y') }
      ]
      text ' '
      text ' '
      font 'Helvetica', style: :bold
      text "Team Manager's Verification"
      font 'Helvetica', style: :normal
      text ' '
      if user.manager_confirmation
        text "I have seen the original ID in player's possession and I certify that the information reported on this form is correct."
        text ' '
        text "Team: #{user.team.name}"
        formatted_text [
          { text: 'Signed:   ' },
          { text: user.manager_signature, styles: [:italic] },
          { text: '     '},
          { text: user.manager_signature_date.strftime('%b %d, %Y') }
        ]
      else
        text "NOT YET Confirmed by team manager #{user.team.manager.name}"
      end
    end
  end
end
