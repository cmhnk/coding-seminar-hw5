require 'minitest/pride'
require 'minitest/autorun'

require_relative 'spreadsheet_validator.rb'

class SpreadsheetValidatorTest < Minitest::Test

  def setup
    @test = SpreadsheetValidator.new('./homework.csv')
  end

  def test_phone_valid
    valid_phones = [true, true, false, true, false, true, false]
    valid_lines = [1, 2, 4, 6]
    assert_equal valid_phones, @test.phone_valid?
  end

  def test_invalid_line_reporter
    invalids = [
      nil,
      nil,
      '(919)333-444 not a valid phone number.',
      nil,
      '(1)2-3 not a valid phone number.',
      nil,
      '000-000-0000 not a valid phone number.'
    ]
    assert_equal invalids, @test.invalid_line_reporter
  end

  def test_hash_builder
    hash_results = [
      {phone: nil},
      {phone: nil},
      {phone: '(919)333-444 not a valid phone number.'},
      {phone: nil},
      {phone: '(1)2-3 not a valid phone number.'},
      {phone: nil},
      {phone: '000-000-0000 not a valid phone number.'}
    ]
    assert_equal hash_results, @test.hash_builder
  end

end
