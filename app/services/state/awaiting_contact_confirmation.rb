module Services
  module State
    class AwaitingContactConfirmation < Base
      def process(user_input)
        store_answer(body: user_input, user: conversation.user)

        case user_input
        when User::CONFIRM_YES
          conversation_strategy.confirm_choise
        when User::CONFIRM_WRONG_EMAIL
          conversation_strategy.wrong_email
        when User::CONFIRM_WRONG_PHONE
          conversation_strategy.wrong_phone
        end
      end

      def state_options
        options = [User::CONFIRM_YES]
        options.push(User::CONFIRM_WRONG_EMAIL) if conversation.user.email
        options.push(User::CONFIRM_WRONG_PHONE) if conversation.user.phone
        options
      end
    end
  end
end
