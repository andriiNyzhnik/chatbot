require 'spec_helper'

describe Services::IOManipulator do
  let(:message) { 'message' }
  let(:conversation) { create :conversation }

  subject { described_class.new(conversation) }

  describe '#read' do
    before { expect(subject).to receive(:gets).and_return("#{ message }\n") }

    it 'gets user input' do
      expect(subject).to receive_message_chain(:gets, :chomp)

      subject.read
    end
  end

  describe '#info' do
    it 'adds answer to conversation' do
      expect{
        subject.info(message)
      }.to change { conversation.messages.where(body: message).count }.by(1)
    end

    it 'prints message to stdout' do
      expect(STDOUT).to receive(:puts).with(message)

      subject.info(message)
    end
  end
end
