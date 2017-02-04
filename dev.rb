require_relative './spreadsheet_validator.rb'

validator = SpreadsheetValidator.new('./homework.csv')

puts validator.phone_valid?

# print validator.phone_regexs
# puts validator.alt_phone_valid?
