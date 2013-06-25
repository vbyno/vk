require 'spec_helper'

describe "apartments/show" do
  before(:each) do
    @apartment = assign(:apartment, stub_model(Apartment,
      :title => "Title",
      :price => "",
      :price => "",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
