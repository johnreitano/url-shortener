require 'rails_helper'

RSpec.configure do |config|
  config.before(:context) {
    @user = FactoryBot.create(:user, email: "a@b.com", password: "123456", password_confirmation: "123456")
    sign_in @user
  }
  config.after(:context) {
    @user.destroy
  }
end

RSpec.describe "ShortenedUrls", type: :request do
  describe "GET /shortened_urls" do
    it "works! (now write some real specs)" do
      # user = FactoryBot.create(:user, password: "123456", password_confirmation: "123456")
      # sign_in user
      get shortened_urls_path
      expect(response).to have_http_status(200)
    end
  end
end
