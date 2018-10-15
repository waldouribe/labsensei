require 'rails_helper'

RSpec.describe "parameter_kinds/edit", type: :view do
  before(:each) do
    @parameter_kind = assign(:parameter_kind, ParameterKind.create!(
      :test_kind => nil,
      :name => "MyString",
      :parameter_type => "MyString"
    ))
  end

  it "renders the edit parameter_kind form" do
    render

    assert_select "form[action=?][method=?]", parameter_kind_path(@parameter_kind), "post" do

      assert_select "input#parameter_kind_test_kind_id[name=?]", "parameter_kind[test_kind_id]"

      assert_select "input#parameter_kind_name[name=?]", "parameter_kind[name]"

      assert_select "input#parameter_kind_parameter_type[name=?]", "parameter_kind[parameter_type]"
    end
  end
end
