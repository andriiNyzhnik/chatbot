module Services
  module State
    class AwaitingContactTime < Base
      def process(user_input)
        store_answer(body: user_input, user: conversation.user) &&
          store_contact_time(user_input) &&
          conversation_strategy.use_confirm_time
      end

      def state_options
        User::CONTACT_TIME_OPTIONS
      end

      private

      def store_contact_time(user_input)
        conversation.user.update_attribute(:contact_time, user_input)
      end
    end
  end
end
