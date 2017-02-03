require 'minitest/pride'
require 'minitest/autorun'

require_relative 'csv_parser.rb'

class CSVParserTest < Minitest::Test
  def test_initialization
    CSVParser.new('./homework.csv')
  end
end
