require 'spec_helper'

describe "apartments/index" do
  before(:each) do
    assign(:apartments, [
      stub_model(Apartment,
        :title => "Title",
        :price => "9.99",
        :description => "MyText"
      ),
      stub_model(Apartment,
        :title => "Title",
        :price => "9.99",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of apartments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
