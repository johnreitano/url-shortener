require 'rails_helper'

RSpec.describe "shortened_urls/index", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user, email: "#{ '%015d' % rand(10 ** 15)}@gmail.com", password: "123456", password_confirmation: "123456")
    assign(:shortened_urls, [

      ShortenedUrl.create!(
        :target_url => "https://#{ '%015d' % rand(10 ** 15)}.com",
        :user_id => @user.id
      ),
      ShortenedUrl.create!(
        :target_url => "https://#{ '%015d' % rand(10 ** 15)}.com",
        :user_id => @user.id
      )
    ])
  end

  it "renders a list of shortened_urls" do
    render
    assert_select "tbody tr", :count => 2
  end
end
