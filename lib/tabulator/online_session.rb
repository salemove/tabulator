module Tabulator
  class OnlineSession
    TriedToRunUnknownMethodOnSession = Class.new(StandardError)
    ArgumentNotRegistered = Class.new(StandardError)
    MethodNotRegisteredOnMapping = Class.new(StandardError)

    attr_reader :operator_session
    attr_reader :visitor_session

    def initialize(operator_session:, visitor_session:, mappings:)
      @operator_session = operator_session
      @visitor_session = visitor_session
      @mappings = mappings
    end

    def bring_participants_online
      run_for_operator :bring_online
      run_for_visitor :bring_online
    end

    def run_for_operator(method_name, argument=nil)
      raise TriedToRunUnknownMethodOnSession, "operator session does not have method: #{method_name}" unless operator_can_run?(method_name)
      if argument != nil
        raise ArgumentNotRegistered, "'#{argument}' not registered as a valid argument" unless allowed_argument?(argument)
      end
      run_in_operator_session(method_name, argument)
    end

    def run_for_visitor(method_name, argument=nil)
      raise TriedToRunUnknownMethodOnSession "visitor session does not have method: #{method_name}" unless visitor_can_run?(method_name)
      if argument != nil
        raise ArgumentNotRegistered, "'#{argument}' not registered as a valid argument" unless allowed_argument?(argument)
      end
      run_in_visitor_session(method_name, argument)
    end

    private

    def operator_can_run?(method_name)
      method_to_run = operator_method method_name
      raise MethodNotRegisteredOnMapping, "'#{method_name}' not registered on operator" unless method_to_run != nil

      @operator_session.respond_to?(method_to_run)
    end

    def visitor_can_run?(method_name)
      method_to_run = visitor_method method_name
      raise MethodNotRegisteredOnMapping, "'#{method_name}' not registered on visitor" unless method_to_run != nil

      @visitor_session.respond_to?(method_to_run)
    end

    def allowed_argument?(argument)
      argument_from_mappings(argument) != nil
    end

    def run_in_operator_session(method_name, argument)
      @operator_session.send(operator_method(method_name), *argument_from_mappings(argument))
    end

    def run_in_visitor_session(method_name, argument)
      @visitor_session.send(visitor_method(method_name), *argument_from_mappings(argument))
    end

    def operator_method(method_name)
      @mappings[:operator_methods][method_name]
    end

    def visitor_method(method_name)
      @mappings[:visitor_methods][method_name]
    end

    def argument_from_mappings(argument)
      @mappings[:allowed_arguments][argument]
    end
  end
end
