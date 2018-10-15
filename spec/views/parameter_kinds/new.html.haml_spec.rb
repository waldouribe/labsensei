require 'rails_helper'

RSpec.describe "parameter_kinds/new", type: :view do
  before(:each) do
    assign(:parameter_kind, ParameterKind.new(
      :test_kind => nil,
      :name => "MyString",
      :parameter_type => "MyString"
    ))
  end

  it "renders new parameter_kind form" do
    render

    assert_select "form[action=?][method=?]", parameter_kinds_path, "post" do

      assert_select "input#parameter_kind_test_kind_id[name=?]", "parameter_kind[test_kind_id]"

      assert_select "input#parameter_kind_name[name=?]", "parameter_kind[name]"

      assert_select "input#parameter_kind_parameter_type[name=?]", "parameter_kind[parameter_type]"
    end
  end
end
