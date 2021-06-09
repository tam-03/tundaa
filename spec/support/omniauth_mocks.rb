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
end
