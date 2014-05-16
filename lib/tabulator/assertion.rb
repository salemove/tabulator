module Tabulator
  class Assertion

    def self.next_from_row(row_enumerator)
      new(operator_local: row_enumerator.next,
          operator_remote: row_enumerator.next,
          visitor_local: row_enumerator.next,
          visitor_remote: row_enumerator.next
          )
    end

    def initialize(operator_local:, operator_remote:, visitor_local:, visitor_remote:)
      @operator_local = operator_local
      @operator_remote = operator_remote
      @visitor_local = visitor_local
      @visitor_remote = visitor_remote
    end

    def call(session)
      puts "Assert: operator local - #{@operator_local}, operator remote - #{@operator_remote}, visitor local - #{@visitor_local}, visitor remote - #{@visitor_remote} "
      check_operator_local(session)
      check_operator_remote(session)
      check_visitor_local(session)
      check_visitor_remote(session)
    end

    private

    def check_operator_local(session)
      session.run_for_operator :check_local, @operator_local
    end

    def check_operator_remote(session)
      session.run_for_operator :check_remote, @operator_remote
    end

    def check_visitor_local(session)
      session.run_for_visitor :check_local, @visitor_local
    end

    def check_visitor_remote(session)
      session.run_for_visitor :check_remote, @visitor_remote
    end
  end
end
