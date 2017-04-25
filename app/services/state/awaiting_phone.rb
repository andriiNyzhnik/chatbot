module Services
  module State
    class AwaitingPhone < Base
      def process(user_input)
        store_answer(body: user_input, user: conversation.user) &&
          store_phone(user_input) &&
          conversation_strategy.choose_contact_time
      end

      private

      def store_phone(user_input)
        conversation.user.update_attribute(:phone, user_input)
      end
    end
  end
end
