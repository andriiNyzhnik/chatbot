module Services
  class ChatBot
    attr_reader :io_manipulator, :conversation, :question_printer, :conversation_strategy

    delegate :read, :info, to: :io_manipulator
    delegate :greeting, :prompt, to: :question_printer
    delegate :completed?, :process, :state_options, to: :conversation_strategy

    def initialize
      @conversation = Conversation.create
      @io_manipulator = IOManipulator.new(conversation)
      @conversation_strategy = ConversationStrategy.new(conversation)
      @question_printer = QuestionPrinter.new(conversation_strategy, conversation: conversation)
    end

    def self.run
      new.run
    end

    def run
      until completed?
        info prompt
        info state_options
        unser_input = read

        process(unser_input)
      end
    end
  end
end
