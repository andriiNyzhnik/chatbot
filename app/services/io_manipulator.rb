module Services
  class IOManipulator
    attr_reader :conversation

    def initialize(conversation)
      @conversation = conversation
    end

    def read
      gets.chomp
    end

    def info(message)
      return unless message

      conversation.messages.create(body: message)
      puts message
    end
  end
end
