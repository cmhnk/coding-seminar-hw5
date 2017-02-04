class SpreadsheetValidator
  attr_reader :csv, :keys
  require 'CSV'
  require_relative './string.rb'

  def initialize(path)
    @csv = CSV.read(path)
    @keys = csv[0]
  end

  def data
    csv[1..-1].map { |row| Hash[keys.zip(row)] }
  end

  def phone_valid?
    valids = []
    data.each do |row|
      valid ||= row['phone'].match?(/^\d{10}/)
      valid ||= row['phone'].match?(/^[^0]\d{2}-[^0]\d{2}-\d{4}/)
      valid ||= row['phone'].match?(/^\W\d{3}\W\s[^0]\d{2}-\d{4}/)
      valid ||= row['phone'].match?(/^[^0]\d{2}\.[^0]\d{2}\.\d{4}/)
      valid ||= row['phone'].match?(/^\W\d{3}\W[^0]d{2}-\d{4}/)
      valid = false if valid.nil?
      valids << valid
    end
    valids
  end

  def invalid_line_reporter
    invalids = []
    data.each_with_index do |row, i|
      valid ||= row['phone'].match(/^\d{10}/)
      valid ||= row['phone'].match(/^[^0]\d{2}-[^0]\d{2}-\d{4}/)
      valid ||= row['phone'].match(/^\W\d{3}\W\s[^0]\d{2}-\d{4}/)
      valid ||= row['phone'].match(/^[^0]\d{2}\.[^0]\d{2}\.\d{4}/)
      valid ||= row['phone'].match(/^\W\d{3}\W[^0]d{2}-\d{4}/)
      if valid.nil?
        invalid = "Line #{i + 1} invalid; #{row['phone']} not a valid phone number."
        invalids << invalid
      end
    end
    invalids
  end

  # def phone_regexs
  #   a = Regexp.new /^\d{10}/
  #   b = Regexp.new /^[^0]\d{2}-[^0]\d{2}-\d{4}/
  #   c = Regexp.new /^\W\d{3}\W\s[^0]\d{2}-\d{4}/
  #   d = Regexp.new /^[^0]\d{2}\.[^0]\d{2}\.\d{4}/
  #   e = Regexp.new /^\W\d{3}\W[^0]d{2}-\d{4}/
  #   [a, b, c, d, e]
  # end
  #
  # def alt_phone_valid?
  #   valids = []
  #   data.each do |row|
  #     valid = nil
  #     phone_regexs.each do |regex|
  #       valid ||= row['phone'].match?(regex)
  #       valid ||= valid
  #     end
  #     valid = false if valid.nil?
  #     valids << valid
  #   end
  #   valids
  # end
end
