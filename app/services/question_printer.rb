require 'erb'

module Services
  class QuestionPrinter
    attr_reader :conversation_strategy, :conversation

    delegate :current_state, to: :conversation_strategy
    delegate :user, to: :conversation

    def initialize(conversation_strategy, conversation:)
      @conversation_strategy = conversation_strategy
      @conversation = conversation
    end

    def prompt
      message = MESSAGES[current_state.to_s]

      fail "Wasn't able to find message for: #{ current_state }" unless message

      ERB.new(message).result(binding)
    end

    private

    def user_name
      user.name
    end

    def contact_type
      user.contact_type
    end
  end
end
