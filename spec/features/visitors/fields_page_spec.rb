# Feature: 'fields' page
#   As a visitor
#   I want to visit a 'fields' page
#   So I can know where I'm going to have to travel to for games
feature 'Fields page' do

  # Scenario: Visit the 'fields' page
  #   Given I am a visitor
  #   When I visit the 'fields' page
  #   Then I see "Fields"
  scenario 'Visit the fields page' do
    visit fields_path
    expect(page).to have_content 'Fields'
  end

end
