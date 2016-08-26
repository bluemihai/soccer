require 'open-uri'

module UsersHelper
end

class RegistrationPdf < Prawn::Document
  def initialize(user, view)
    info = {page_size: "A4", page_layout: :portrait, margin: 10}
    super(info)
    image "#{Rails.root}/app/assets/images/reg_form_top.png", height: 90, width: 725
    text user.name
    text user.email
    image open(user.photo.url), height: 150, width: 150
  end
end
