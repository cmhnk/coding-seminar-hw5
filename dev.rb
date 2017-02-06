require_relative './spreadsheet_validator.rb'

validator = SpreadsheetValidator.new('./homework.csv')
puts validator.print_to_screen
