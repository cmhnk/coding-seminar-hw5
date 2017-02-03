class SpreadsheetValidator
  attr_reader :csv, :keys
  require 'CSV'

  def initialize(path)
    @csv = CSV.read(path)
    @keys = csv[0]
  end

  def data
    csv[1..-1].map { |row| Hash[keys.zip(row)] }
  end

  def phone_valid?
    # stuff
  end
end
