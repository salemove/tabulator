module Tabulator
  class MediaAssertion
    MediaNotFlowing = Class.new(StandardError)

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
      check_operator_local(session)
      check_operator_remote(session)
      check_visitor_local(session)
      check_visitor_remote(session)
    end

    private

    def check_operator_local(session)
      session.operator_session.local_media_flowing?
    end

    def check_operator_remote(session)
      session.operator_session.remote_media_flowing?
    end

    def check_visitor_local(session)
      session.visitor_session.local_media_flowing?
    end

    def check_visitor_remote(session)
      session.visitor_session.remote_media_flowing?
    end
  end
end
