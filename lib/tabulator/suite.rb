module Tabulator
  class Suite
    def initialize(test_cases:)
      @test_cases = test_cases
    end

    def run(session)
      @test_cases.each do |test_case|
        test_case.run(session)
      end
    end

    def tests
      @test_cases
    end
  end
end
