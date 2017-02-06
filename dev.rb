require_relative './spreadsheet_validator.rb'

validator = SpreadsheetValidator.new('./homework.csv')

trying = [validator.send(:invalid_phone_reporter), validator.send(:invalid_date_reporter), validator.send(:invalid_email_reporter)]
puts validator.print_to_screen
