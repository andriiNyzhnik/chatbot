module Services
  module State
    class ContactFailed < Base
      def process(user_input)
        store_answer(body: user_input, user: conversation.user) &&
          conversation_strategy.tragic_end
      end
    end
  end
end
