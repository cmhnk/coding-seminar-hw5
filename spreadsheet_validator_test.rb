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
    assert_equal invalids, @test.invalid_phone_reporter
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
    assert_equal invalids, @test.invalid_date_reporter
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
    assert_equal invalids, @test.invalid_email_reporter
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
