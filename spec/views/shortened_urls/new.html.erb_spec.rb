require 'rails_helper'

RSpec.describe "shortened_urls/new", type: :view do
  before(:each) do
    assign(:shortened_url, ShortenedUrl.new(
      :target_url => "MyString",
      :short_path => "",
      :user_id => 1
    ))
  end

  it "renders new shortened_url form" do
    render

    assert_select "form[action=?][method=?]", shortened_urls_path, "post" do

      assert_select "input[name=?]", "shortened_url[target_url]"

    end
  end
end
