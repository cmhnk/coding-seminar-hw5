require_relative './spreadsheet_validator.rb'

validator = SpreadsheetValidator.new('./homework.csv')

trying = [validator.invalid_phone_reporter, validator.invalid_date_reporter, validator.invalid_email_reporter]
print trying.transpose
