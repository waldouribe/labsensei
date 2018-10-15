require 'rails_helper'

RSpec.describe "tests/edit", type: :view do
  before(:each) do
    @test = assign(:test, Test.create!(
      :test_kind => nil,
      :patient => nil
    ))
  end

  it "renders the edit test form" do
    render

    assert_select "form[action=?][method=?]", test_path(@test), "post" do

      assert_select "input#test_test_kind_id[name=?]", "test[test_kind_id]"

      assert_select "input#test_patient_id[name=?]", "test[patient_id]"
    end
  end
end
