require 'rails_helper'

RSpec.describe "test_kinds/edit", type: :view do
  before(:each) do
    @test_kind = assign(:test_kind, TestKind.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit test_kind form" do
    render

    assert_select "form[action=?][method=?]", test_kind_path(@test_kind), "post" do

      assert_select "input#test_kind_name[name=?]", "test_kind[name]"
    end
  end
end
