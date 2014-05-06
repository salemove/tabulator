module Tabulator
  class Action
    ACTION_MAPPINGS = {
      :offer_video => :offer_video_engagement
    }
    RESPONSE_MAPPINGS = {
      :video => :accept_incoming_video_call
    }

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
      puts "Tabulator::Action#call running action #{@action} for #{@initiator} and #{@response} for other"
      if @initiator == :operator
        session.run_for_operator(ACTION_MAPPINGS[@action])
        session.run_for_visitor(RESPONSE_MAPPINGS[@response])
      else
        session.run_for_visitor(ACTION_MAPPINGS[@action])
        session.run_for_operator(RESPONSE_MAPPINGS[@response])
      end
    end
  end
end
