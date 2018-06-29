require 'rails_helper'

RSpec.describe "admins/new", type: :view do
  before(:each) do
    assign(:admin, Admin.new(
      :admin_id => "MyString",
      :password_digest => "MyString"
    ))
  end

  it "renders new admin form" do
    render

    assert_select "form[action=?][method=?]", admins_path, "post" do

      assert_select "input[name=?]", "admin[admin_id]"

      assert_select "input[name=?]", "admin[password_digest]"
    end
  end
end