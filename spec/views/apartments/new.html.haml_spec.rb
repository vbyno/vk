require 'spec_helper'

describe "apartments/new" do
  before(:each) do
    assign(:apartment, stub_model(Apartment,
      :title => "MyString",
      :price => "9.99",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new apartment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", apartments_path, "post" do
      assert_select "input#apartment_title[name=?]", "apartment[title]"
      assert_select "input#apartment_price[name=?]", "apartment[price]"
      assert_select "textarea#apartment_description[name=?]", "apartment[description]"
    end
  end
end
