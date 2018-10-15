require 'rails_helper'

RSpec.describe "test_kinds/index", type: :view do
  before(:each) do
    assign(:test_kinds, [
      TestKind.create!(
        :name => "Name"
      ),
      TestKind.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of test_kinds" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
