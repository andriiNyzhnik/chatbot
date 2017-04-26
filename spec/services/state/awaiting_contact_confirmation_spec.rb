require 'spec_helper'

describe Services::State::AwaitingContactConfirmation do
  let(:user_input) { 'input' }
  let(:user) { create :user }
  let(:conversation) { create :conversation, users: [user] }
  let(:conversation_strategy) { Services::ConversationStrategy.new(conversation) }

  subject { described_class.new(conversation_strategy) }

  describe '#process' do
    context 'when user confirm' do
      let(:user_input) { User::CONFIRM_YES }

      before { expect(conversation_strategy).to receive(:confirm_choise) }

      include_context 'common state behaviour'
    end

    context 'when user rejects email' do
      let(:user_input) { User::CONFIRM_WRONG_EMAIL }

      before { expect(conversation_strategy).to receive(:wrong_email) }

      include_context 'common state behaviour'
    end
  end

  describe '#state_options' do
    context 'when user has email' do
      let(:user) { create :user, email: 'valera@gmail.com' }

      it 'return list of options' do
        expect(
          subject.state_options
        ).to match_array([User::CONFIRM_YES, User::CONFIRM_WRONG_EMAIL])
      end
    end

    context 'when user has phone' do
      let(:user) { create :user, phone: '134134134243' }

      it 'returns list of options' do
        expect(
          subject.state_options
        ).to match_array([User::CONFIRM_YES, User::CONFIRM_WRONG_PHONE])
      end
    end
  end
end
