require 'rails_helper'

RSpec.describe "entries/edit", type: :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :entry_name => "MyString",
      :entry_email => "MyString"
    ))
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", entry_path(@entry), "post" do

      assert_select "input[name=?]", "entry[entry_name]"

      assert_select "input[name=?]", "entry[entry_email]"
    end
  end
end
