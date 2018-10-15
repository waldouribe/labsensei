require 'rails_helper'

RSpec.describe "parameter_kinds/show", type: :view do
  before(:each) do
    @parameter_kind = assign(:parameter_kind, ParameterKind.create!(
      :test_kind => nil,
      :name => "Name",
      :parameter_type => "Parameter Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Parameter Type/)
  end
end
