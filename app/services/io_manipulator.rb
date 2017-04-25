module Services
  class IOManipulator
    attr_reader :conversation

    def initialize(conversation)
      @conversation = conversation
    end

    def read
      user_input = gets.chomp
      # conversation.answers.create(body: user_input)
      user_input
    end

    def info(message)
      return unless message

      conversation.messages.create(body: message)
      puts message
    end
  end
end
