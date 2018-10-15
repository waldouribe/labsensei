require 'rails_helper'

RSpec.describe "tests/new", type: :view do
  before(:each) do
    assign(:test, Test.new(
      :test_kind => nil,
      :patient => nil
    ))
  end

  it "renders new test form" do
    render

    assert_select "form[action=?][method=?]", tests_path, "post" do

      assert_select "input#test_test_kind_id[name=?]", "test[test_kind_id]"

      assert_select "input#test_patient_id[name=?]", "test[patient_id]"
    end
  end
end
