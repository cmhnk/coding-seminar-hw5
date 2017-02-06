class SpreadsheetValidator

  require 'CSV'
  require_relative './string.rb'

  attr_reader :csv, :keys

  def initialize(path)
    @csv = CSV.read(path)
    @keys = csv[0]
  end

  def print_to_screen
    string = "Checking your CSV...\n" + valid_line_reporter + "\n\n" + error_reporter + "\n"
  end

  private

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

  def row_validation_reporter
    validations = [
      invalid_date_reporter,
      invalid_email_reporter,
      invalid_phone_reporter
    ]
    validations.transpose
  end

  def valid_lines
    total = 0
    row_validation_reporter.each do |row|
      if row.compact.empty?
        total += 1
      end
    end
    total
  end

  def valid_line_reporter
    if valid_lines == 1
      "There was 1 valid line in your CSV."
    elsif valid_lines > 1
      "There were #{valid_lines} valid lines in your CSV."
    end
  end

  def error_reporter
    accumulator = []
    row_validation_reporter.each.with_index(1) do |row, i|
      if !row.compact.empty?
        error = "ERROR: Line #{i} is invalid:\n"
        row_errors = []
        row.each do |error|
          row_errors << error + " " + "\n" unless error.nil?
        end
        spacer = "\n"
        accumulator << error + row_errors.join + spacer
      end
    end
    accumulator.join
  end

end
