module Services
  class ChatBot
    attr_reader :io_manipulator, :conversation, :question_printer

    delegate :read, :info, to: :io_manipulator
    delegate :greeting, to: :question_printer

    def initialize
      @conversation = Conversation.create
      @io_manipulator = IOManipulator.new(conversation)
      @question_printer = QuestionPrinter.new
    end

    def self.run
      new.run
    end

    def run
      info greeting
      read
    end
  end
end
