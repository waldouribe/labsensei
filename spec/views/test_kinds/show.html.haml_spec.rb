require 'rails_helper'

RSpec.describe "test_kinds/show", type: :view do
  before(:each) do
    @test_kind = assign(:test_kind, TestKind.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
