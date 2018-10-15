require 'rails_helper'

RSpec.describe "parameter_kinds/index", type: :view do
  before(:each) do
    assign(:parameter_kinds, [
      ParameterKind.create!(
        :test_kind => nil,
        :name => "Name",
        :parameter_type => "Parameter Type"
      ),
      ParameterKind.create!(
        :test_kind => nil,
        :name => "Name",
        :parameter_type => "Parameter Type"
      )
    ])
  end

  it "renders a list of parameter_kinds" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Parameter Type".to_s, :count => 2
  end
end
