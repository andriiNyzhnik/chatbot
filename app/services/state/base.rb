module Services
  module State
    class Base
      attr_reader :conversation_strategy

      delegate :conversation, to: :conversation_strategy

      def initialize(conversation_strategy)
        @conversation_strategy = conversation_strategy
      end

      def process(user_input)
        fail NotImplementError
      end

      def state_options; end

      private

      def store_answer(options = {})
        conversation.answers.create(options)
      end
    end
  end
end
