require_dependency 'app/services/state/base'

module Services
  module State
    class AwaitingAnyInput < Base
      def process(user_input)
        store_answer(body: user_input) && conversation_strategy.move
      end
    end
  end
end
