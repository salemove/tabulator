require 'csv'

module Tabulator
  class CsvParser
    def self.parse(path)
      new(CSV.read(path)).parse
    end

    def initialize(rows)
      @rows = rows
    end

    def parse
      data_rows.map do |row|
        description = row[0]
        tests = row[1..-1].map(&method(:string_to_snake))
        tests.insert(0, description)
      end
    end

    private

    # CSV Rows after header row
    def data_rows
      @rows[1..-1]
    end

    def string_to_snake(string)
      if !string.nil?
        string.squish.downcase.tr(" ","_").to_sym
      end
    end
  end
end
