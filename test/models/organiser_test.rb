require 'test_helper'

class OrganiserTest < ActiveSupport::TestCase
  test "organiser name has to be unique" do
    organiser1 = FactoryBot.create(:organiser, name: "Event 1")
    organiser2 = FactoryBot.build(:organiser, name: "Event 1")
    assert_not organiser2.valid?
  end

  test "organiser name cannot be blank" do
    organiser = FactoryBot.build(:organiser, name: "  ")
    assert_not organiser.valid?
  end

  test "organiser name cannot be empty" do
    organiser = FactoryBot.build(:organiser, name: "")
    assert_not organiser.valid?
  end
end
