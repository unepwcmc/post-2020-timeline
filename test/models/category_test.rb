require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category name has to be unique" do
    category1 = FactoryBot.create(:category, name: "Event 1")
    category2 = FactoryBot.build(:category, name: "Event 1")
    assert_not category2.valid?
  end

  test "category name cannot be blank" do
    category = FactoryBot.build(:category, name: "  ")
    assert_not category.valid?
  end

  test "category name cannot be empty" do
    category = FactoryBot.build(:category, name: "")
    assert_not category.valid?
  end
end
