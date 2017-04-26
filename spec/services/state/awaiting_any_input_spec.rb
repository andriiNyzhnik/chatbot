require 'spec_helper'

describe Services::State::AwaitingAnyInput do
  let(:user_input) { 'input' }
  let(:conversation) { create :conversation }
  let(:conversation_strategy) { Services::ConversationStrategy.new(conversation) }

  subject { described_class.new(conversation_strategy) }

  describe '#process' do
    it 'stores user answer' do
      expect{
        subject.process(user_input)
      }.to change { conversation.answers.where(body: user_input).count }.by(1)
    end

    it 'calls move' do
      expect(conversation_strategy).to receive(:move)

      subject.process(user_input)
    end
  end
end
