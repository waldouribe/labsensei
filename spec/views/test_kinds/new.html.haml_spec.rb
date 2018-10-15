require 'rails_helper'

RSpec.describe "test_kinds/new", type: :view do
  before(:each) do
    assign(:test_kind, TestKind.new(
      :name => "MyString"
    ))
  end

  it "renders new test_kind form" do
    render

    assert_select "form[action=?][method=?]", test_kinds_path, "post" do

      assert_select "input#test_kind_name[name=?]", "test_kind[name]"
    end
  end
end
