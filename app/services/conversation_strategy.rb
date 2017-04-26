require 'aasm'

module Services
  class ConversationStrategy
    include AASM

    attr_reader :conversation

    delegate :current_state, to: :aasm
    delegate :state_options, to: :handler

    def initialize(conversation)
      @conversation = conversation
    end

    aasm do
      state :awaiting_any_input, initial: true
      state :awaiting_user_name
      state :contact_failed
      state :awaiting_phone
      state :awaiting_email
      state :happy_end
      state :tragic_end
      state :awaiting_contact_type
      state :awaiting_contact_confirmation
      state :awaiting_contact_time

      event :move do
        transitions from: :awaiting_any_input, to: :awaiting_user_name
        transitions from: :awaiting_user_name, to: :awaiting_contact_type
      end

      event :use_phone do
        transitions from: :awaiting_contact_type, to: :awaiting_phone
      end

      event :use_email do
        transitions from: :awaiting_contact_type, to: :awaiting_email
      end

      event :dont_contact do
        transitions from: :awaiting_contact_type, to: :contact_failed
      end

      event :tragic_end do
        transitions from: :contact_failed, to: :tragic_end
      end

      event :confirm_contact do
        transitions from: :awaiting_email, to: :awaiting_contact_confirmation
      end

      event :confirm_choise do
        transitions from: :awaiting_contact_confirmation, to: :happy_end
      end

      event :wrong_email do
        transitions from: :awaiting_contact_confirmation, to: :awaiting_email
      end

      event :wrong_phone do
        transitions from: :awaiting_contact_confirmation, to: :awaiting_phone
      end

      event :choose_contact_time do
        transitions from: :awaiting_phone, to: :awaiting_contact_time
      end

      event :use_confirm_time do
        transitions from: :awaiting_contact_time, to: :awaiting_contact_confirmation
      end
    end

    def completed?
      [STATE_HAPPY_END, STATE_TRAGIC_END].include?(current_state)
    end

    def process(user_input)
      handler.process(user_input)
    end

    private

    def handler
      State.const_get(current_state.to_s.camelize).new(self)
    end
  end
end
