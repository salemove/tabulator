module Tabulator
  class TestCase
    attr_reader :description

    def initialize(initial, steps, description)
      @initial = initial
      @steps = steps
      @description = description
    end

    def run(session)
      session.bring_participants_online
      @initial.call(session)
      @steps.each { |t| t.call(session) }
    end
  end
end
