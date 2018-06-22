require 'rails_helper'

RSpec.describe "entries/index", type: :view do
  before(:each) do
    assign(:entries, [
      Entry.create!(
        :entry_name => "Entry Name",
        :entry_email => "Entry Email"
      ),
      Entry.create!(
        :entry_name => "Entry Name",
        :entry_email => "Entry Email"
      )
    ])
  end

  it "renders a list of entries" do
    render
    assert_select "tr>td", :text => "Entry Name".to_s, :count => 2
    assert_select "tr>td", :text => "Entry Email".to_s, :count => 2
  end
end
