module Services
  module State
    class AwaitingEmail < Base
      def process(user_input)
        store_answer(body: user_input, user: conversation.user) &&
          store_email(user_input) &&
          conversation_strategy.confirm_contact
      end

      private

      def store_email(user_input)
        conversation.user.update_attribute(:email, user_input)
      end
    end
  end
end
