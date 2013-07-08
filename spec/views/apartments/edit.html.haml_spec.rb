require 'spec_helper'

describe "apartments/edit" do
  before(:each) do
    @apartment = assign(:apartment, stub_model(Apartment,
      :title => "MyString",
      :price => "9.99",
      :description => "MyText"
    ))
  end

  it "renders the edit apartment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", apartment_path(@apartment), "post" do
      assert_select "input#apartment_title[name=?]", "apartment[title]"
      assert_select "input#apartment_price[name=?]", "apartment[price]"
      assert_select "textarea#apartment_description[name=?]", "apartment[description]"
    end
  end
end
