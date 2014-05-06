module Tabulator
  class Importer
    def self.import(rows)
      rows.map do |row|
        operator_initialization = OperatorInitiator.new(row[1])
        engagement_steps = TestStep.all_from(row[2..-1])
        TestCase.new operator_initialization, engagement_steps
      end
    end
  end
end
