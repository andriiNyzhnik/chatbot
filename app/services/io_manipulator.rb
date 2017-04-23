module Services
  class IOManipulator
    attr_reader :conversation

    def initialize(conversation)
      @conversation = conversation
    end

    def read
      conversation.answers.create(body: gets.chomp)
    end

    def info(message)
      conversation.messages.create(body: message)

      puts message
    end
  end
end
