require_relative 'action'
require_relative 'media_assertion'

module Tabulator
  class TestStep

    def self.all_from(row)
      row_iterator = row.each
      steps = []
      while true
        action = Action.next_from_row row_iterator
        assertion = MediaAssertion.next_from_row row_iterator
        steps << new(action, assertion)
      end
    rescue StopIteration
      steps
    end

    def initialize(action, checkpoint)
      @action = action
      @checkpoint = checkpoint
    end

    def call(session)
      @action.call(session)
      @checkpoint.call(session)
    end
  end
end
