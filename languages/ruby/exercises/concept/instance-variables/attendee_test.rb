require 'minitest/autorun'
require_relative 'attendee'

class AttendeeTest < Minitest::Test
  def test_new_instance_height
    height = 100
    assert_equal height, Attendee.new(height).height
  end

  def test_new_instance_doesnt_have_pass
    refute Attendee.new(100).has_pass?
  end

  def test_issue_pass
    height = 100
    attendee = Attendee.new(height)

    pass_id = 1
    attendee.issue_pass!(pass_id)

    assert_equal pass_id, attendee.pass_id
  end

  def test_has_pass_after_issue
    attendee = Attendee.new(100)
    attendee.issue_pass!(1)
    assert attendee.has_pass?
  end

  def test_pass_id_instance_when_revoked
    attendee = Attendee.new(100)
    attendee.issue_pass!(1)
    attendee.revoke_pass!
    assert_nil attendee.instance_variable_get(:@pass_id)
  end

  def test_has_pass_after_revoked
    height = 100
    attendee = Attendee.new(height)
    pass_id = 1
    attendee.issue_pass!(pass_id)
    attendee.revoke_pass!
    refute attendee.has_pass?
  end

  def test_fits_ride_exactly
    assert Attendee.new(100).fits_ride?(100)
  end

  def test_fits_small_ride
    assert Attendee.new(100).fits_ride?(80)
  end

  def test_doesnt_fit_big_ride
    refute Attendee.new(100).fits_ride?(110)
  end

  def test_fits_ride_but_no_pass
    refute Attendee.new(100).allowed_to_ride?(100)
  end

  def test_fits_ride_and_has_pass
    attendee = Attendee.new(100)
    attendee.issue_pass!(1)
    assert attendee.allowed_to_ride?(100)
  end
end
