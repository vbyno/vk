require 'spec_helper'

describe "apartments/show" do
  before(:each) do
    @apartment = assign(:apartment, stub_model(Apartment,
      :title => "Title",
      :price => "9.99",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/9.99/)
    rendered.should match(/MyText/)
  end
end
