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
    t = FactoryGirl.create(:team, name: 'Barcelona')
    invitee = FactoryGirl.create(:player, team: t, invited: true, email: 'mockuser@example.com')
    puts "Player.find_by(email: 'mockuser@example.com').inspect: #{Player.find_by(email: 'mockuser@example.com').inspect}"
    puts "User.count: #{User.count}"
    signin
    expect(page).to have_content("Update Team Profile")
  end

end
