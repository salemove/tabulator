module Tabulator
  class Action

    def self.next_from_row(row_enumerator)
      new(initiator: row_enumerator.next,
          action: row_enumerator.next,
          response: row_enumerator.next
          )
    end

    def initialize(initiator:, action:, response:)
      @initiator = initiator
      @action = action
      @response = response
    end

    def call(session)
      p "#{@initiator} #{@action} and respond with #{@response}"
      if @initiator == :operator
        session.run_for_operator(@action)
        session.run_for_visitor(@response)
      else
        session.run_for_visitor(@action)
        session.run_for_operator(@response)
      end
    end
  end
end
