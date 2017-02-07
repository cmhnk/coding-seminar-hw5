require 'minitest/pride'
require 'minitest/autorun'

require_relative 'spreadsheet_validator.rb'

class SpreadsheetValidatorTest < Minitest::Test

  def setup
    @test = SpreadsheetValidator.new('./homework.csv')
  end

  def test_invalid_phone_reporter
    invalids = [
      nil,
      nil,
      '(919)333-444 not a valid phone number.',
      nil,
      '(1)2-3 not a valid phone number.',
      nil,
      '000-000-0000 not a valid phone number.'
    ]
    assert_equal invalids, @test.send(:invalid_phone_reporter)
  end

  def test_invalid_date_reporter
    invalids = [
      nil,
      '2016-02 not a valid date.',
      nil,
      '13/03/2016 not a valid date.',
      '442016 not a valid date.',
      nil,
      'Yesterday not a valid date.'
    ]
    assert_equal invalids, @test.send(:invalid_date_reporter)
  end

  def test_invalid_email_reporter
    invalids = [
      nil,
      'bob@bob@bob.com not a valid email.',
      'cindy@cindy not a valid email.',
      nil,
      nil,
      nil,
      nil
    ]
    assert_equal invalids, @test.send(:invalid_email_reporter)
  end

  def test_row_validation_reporter
    expected = [
      [nil, nil, nil],
      ['2016-02 not a valid date.', 'bob@bob@bob.com not a valid email.', nil],
      [nil, 'cindy@cindy not a valid email.', '(919)333-444 not a valid phone number.'],
      ['13/03/2016 not a valid date.', nil, nil],
      ['442016 not a valid date.', nil, '(1)2-3 not a valid phone number.'],
      [nil, nil, nil],
      ['Yesterday not a valid date.', nil, '000-000-0000 not a valid phone number.']
    ]
    assert_equal expected, @test.send(:row_validation_reporter)
  end

  def test_public_method
    @test.print_to_screen
  end
end
