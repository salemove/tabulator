module Tabulator
  module TableColumnRanges
    OPERATOR_INITIAL_MEDIA_COLUMNS = (0..0)
    INITIAL_ENGAGEMENT_MEDIA = (1..3)
  end

  class OnlineSession
    TriedToRunUnknownMethodOnSession = Class.new(StandardError)

    attr_reader :operator_session
    attr_reader :visitor_session

    def initialize(operator_session:, visitor_session:)
      @operator_session = operator_session
      @visitor_session = visitor_session
    end

    def run_for_operator(method_name)
      raise TriedToRunUnknownMethodOnSession, "operator session: #{method_name}" unless operator_can_run?(method_name)
      @operator_session.send(method_name)
    end

    def run_for_visitor(method_name)
      raise TriedToRunUnknownMethodOnSession "visitor session: #{method_name}" unless visitor_can_run?(method_name)
      @visitor_session.send(method_name)
    end

    def bring_participants_online
      @operator_session.go_to_home_view
      @visitor_session.go_to_test_page
    end

    def end_sessions
      # Remove once dynamic it block generation is done
      reset_session @operator_session
      reset_session @visitor_session
    end

    private

    def operator_can_run?(method_name)
      @operator_session.respond_to?(method_name)
    end

    def visitor_can_run?(method_name)
      @visitor_session.respond_to?(method_name)
    end
  end
end
