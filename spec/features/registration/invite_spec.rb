# Feature: Sign in
#   As a manager
#   I want to invite a player to join the team
#   So that I can visualize my roster-in-progress
feature 'Sign in', :omniauth do

  # Scenario: Already-invited player can sign in to accept invite
  #   Given I have a player invitation
  #   And I am not signed in
  #   When I sign in with the e-mail that received the invite
  #   Then I see a success message
  scenario "invited player can accept" do
    le = FactoryGirl.create(:user, name: 'Luis Enrique')
    b = FactoryGirl.create(:team, name: 'FC Barcelona', manager: le)
    invitee = FactoryGirl.create(
      :player, team: b, invited: true, email: 'mockuser@example.com')
    signin
    u = User.last
    expect(u.manager.name).to eq('Luis Enrique')
    expect(page).to have_content('FC Barcelona')
    expect(page).to have_content('Update Team Profile')
  end

  # Scenario: Not-yet-invited player can sign in and join team
  #   Given I do not have a player invitation
  #   And I am not signed in
  #   When I sign in with the e-mail that received the invite
  #   Then I am not automatically added to a team
  scenario "invited player can accept" do
    b = FactoryGirl.create(:team, name: 'FC Barcelona')
    signin
    expect(page).not_to have_content('FC Barcelona')
    expect(page).not_to have_content('Update Team Profile')
  end

end
