require 'rails_helper'

RSpec.describe "entries/new", type: :view do
  before(:each) do
    assign(:entry, Entry.new(
      :entry_name => "MyString",
      :entry_email => "MyString"
    ))
  end

  it "renders new entry form" do
    render

    assert_select "form[action=?][method=?]", entries_path, "post" do

      assert_select "input[name=?]", "entry[entry_name]"

      assert_select "input[name=?]", "entry[entry_email]"
    end
  end
end
