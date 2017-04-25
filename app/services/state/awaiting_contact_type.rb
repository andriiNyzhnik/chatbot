module Services
  module State
    class AwaitingContactType < Base
      def process(user_input)
        store_answer(body: user_input, user: conversation.user) &&
          store_contact_type(user_input)

        case user_input
        when User::EMAIL_OPTION
          conversation_strategy.use_email
        when User::PHONE_OPTION
          conversation_strategy.use_phone
        when User::DONT_CONTACT_OPTION
          conversation_strategy.dont_contact
        end
      end

      def state_options
        User::CONTACT_OPTIONS
      end

      private

      def store_contact_type(user_input)
        conversation.user.update_attribute(:contact_type, user_input)
      end
    end
  end
end
