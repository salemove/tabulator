module Tabulator
  class OperatorInitiator

    def initialize(initial_media)
      @initial_media = initial_media
    end

    def call(session)
      session.run_for_operator(@initial_media)
    end
  end
end
