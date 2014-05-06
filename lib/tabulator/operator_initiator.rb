module Tabulator
  class OperatorInitiator
    MAPPINGS = {
      :off => nil,
      :audio => :turn_on_mic,
      :video => :turn_on_video
    }

    def initialize(initial_media)
      @initial_media = initial_media
    end

    def call(session)
      p "Tabular::Initiator running #{@initial_media} for #{session}"
      if MAPPINGS[@initial_media]
        session.run_for_operator(MAPPINGS[@initial_media])
      end
    end
  end
end
