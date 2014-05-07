module Tabulator
  class Importer
    def self.import(rows)
      rows.map do |row|
        description = row[0]
        operator_initialization = OperatorInitiator.new(row[1])
        engagement_steps = TestStep.all_from(row[2..-1].compact)
        TestCase.new operator_initialization, engagement_steps, description
      end
    end
  end
end
