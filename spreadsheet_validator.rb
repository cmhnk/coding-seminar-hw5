class SpreadsheetValidator

  require 'CSV'
  require_relative './string.rb'

  attr_reader :csv, :keys

  def initialize(path)
    @csv = CSV.read(path)
    @keys = csv[0]
  end

  def data
    csv[1..-1].map { |row| Hash[keys.zip(row)] }
  end

  def invalid_phone_reporter
    invalids = []
    data.each do |row|
      valid ||= row['phone'].match(/^\d{10}/)
      valid ||= row['phone'].match(/^[^0]\d{2}-[^0]\d{2}-\d{4}/)
      valid ||= row['phone'].match(/^\W\d{3}\W\s[^0]\d{2}-\d{4}/)
      valid ||= row['phone'].match(/^[^0]\d{2}\.[^0]\d{2}\.\d{4}/)
      valid ||= row['phone'].match(/^\W\d{3}\W[^0]d{2}-\d{4}/)

      invalid = valid.nil? ? "#{row['phone']} not a valid phone number." : nil
      invalids << invalid
    end
    invalids
  end

  def invalid_date_reporter
    invalids = []
    data.each do |row|
      valid ||= row['joined'].match(/\d\/\d\/\d{2}/)
      valid ||= row['joined'].match(/\d\/\d\/\d{4}/)
      valid ||= row['joined'].match(/^[^2-9][0-2 | \/]\/[^4-9]\d\/\d{4}/)
      valid ||= row['joined'].match(/\d{4}[\- | \/]\d{2}[\- | \/]\d{2}/)
      valid ||= row['joined'].match(/^[^2-9][0-2][\- | \/][^4-9]\d[\- | \/]\d{4}/)

      invalid = valid.nil? ? "#{row['joined']} not a valid date." : nil
      invalids << invalid
    end
    invalids
  end

  def invalid_email_reporter
    invalids = []
    data.each do |row|
      valid ||= row['email'].match(/(^[\w\-\.[^\@]]+)@([\w]+\.)+([a-zA-Z]{2,3})/)

      invalid = valid.nil? ? "#{row['email']} not a valid email." : nil
      invalids << invalid
    end
    invalids
  end

  def hash_builder
    hash_results = []
    invalid_phone_reporter.each do |row|
      hash_results << Hash[phone: row]
    end
    hash_results
  end
end
#
# /\d\/\d\/\d{2}/
# /\d\/\d\/\d{4}/
# /^[^2-9][0-2 | \/]\/[^4-9]\d\/\d{4}/
# /\d{4}[\- | \/]\d{2}[\- | \/]\d{2}/
# /^[^2-9][0-2][\- | \/][^4-9]\d[\- | \/]\d{4}/

/([\w\-\.]+)@([\w]+\.)+([a-zA-Z]{2,3})/
