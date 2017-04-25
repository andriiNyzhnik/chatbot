module Services
  module State
    class AwaitingUserName < Base
      attr_reader :user

      def process(user_input)
        create_user(user_input) &&
          store_answer(body: user_input, user: user) &&
          conversation_strategy.move
      end

      private

      def create_user(user_input)
        @user = User.create(name: user_input)
      end
    end
  end
end
