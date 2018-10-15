require 'rails_helper'

RSpec.describe "tests/index", type: :view do
  before(:each) do
    assign(:tests, [
      Test.create!(
        :test_kind => nil,
        :patient => nil
      ),
      Test.create!(
        :test_kind => nil,
        :patient => nil
      )
    ])
  end

  it "renders a list of tests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
