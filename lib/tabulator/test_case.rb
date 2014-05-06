module Tabulator
  class TestCase

    def initialize(initial, steps)
      @initial = initial
      @steps = steps
    end

    def run(session)
      session.bring_participants_online
      @initial.call(session)
      @steps.each { |t| t.call(session) }
      session.end_sessions
    end
  end
end
