require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase

    def setup
        @user = users(:john)
        @trial = trials(:one)
        @volunteer = @user.volunteers.build(notes: "After 6pm.",
                                            trial: @trial)
    end

    test "should be valid" do
        assert @volunteer.valid?
    end

    test "user id should be present" do
        @volunteer.user_id = nil
        assert_not @volunteer.valid?
    end

end
