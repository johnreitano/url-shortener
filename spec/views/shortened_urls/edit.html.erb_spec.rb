require 'rails_helper'

RSpec.describe "shortened_urls/edit", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user, email: "#{ '%015d' % rand(10 ** 15)}@gmail.com", password: "123456", password_confirmation: "123456")
    @shortened_url = assign(:shortened_url, ShortenedUrl.create!(
      :target_url => "MyString",
      :short_path => "",
      :user_id => @user.id
    ))
  end

  it "renders the edit shortened_url form" do
    render

    assert_select "form[action=?][method=?]", shortened_url_path(@shortened_url), "post" do
      assert_select "input[name=?]", "shortened_url[short_path]"
    end
  end
end
