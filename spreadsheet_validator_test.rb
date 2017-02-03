require 'minitest/pride'
require 'minitest/autorun'

require_relative 'spreadsheet_validator.rb'

class CSVParserTest < Minitest::Test

  def setup
    @test = SpreadsheetValidator.new('./homework.csv')
  end

  def test_initialization
    CSVParser.new('./homework.csv')
  end

  def test_phone_valid
    valid_phones = [true, true, true, true, false, true, false]
    valid_lines = [1, 2, 3, 4, 6]
    assert_equal valid_phones, @test.phone_valid?
  end
end
