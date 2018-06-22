require 'rails_helper'

RSpec.describe "entries/show", type: :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :entry_name => "Entry Name",
      :entry_email => "Entry Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Entry Name/)
    expect(rendered).to match(/Entry Email/)
  end
end
