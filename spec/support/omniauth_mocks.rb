# frozen_string_literal: true

module OmniauthMocks
  def github_mock
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :info => {
        :nickname => "Alice",
        :email => "alice@example.com",
        :name => "Alice",
      },
    })
  end
  def google_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123545',
      :info => {
        :email => "bob@example.com",
        :name => "Bob",
      },
    })
  end
end
