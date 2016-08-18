module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:google_oauth2] = {
        'provider' => 'google_oauth2',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'email' => 'mockuser@example.com'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      }
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in...")
      auth_mock
      click_link 'Google auth'
    end
  end

end
