require 'spec_helper'

describe Services::ConversationStrategy do
  let(:conversation) { create :conversation }

  subject { described_class.new(conversation) }

  it { is_expected.to be_awaiting_any_input }

  context 'when user enters some input' do
    before { subject.process('some data') }

    it { is_expected.to be_awaiting_user_name }

    context 'and user enters his name' do
      before { subject.process('user name') }

      it { is_expected.to be_awaiting_contact_type }

      context "and user enters, that doesn't want to be contacted" do
        before { subject.process(User::DONT_CONTACT_OPTION) }

        it { is_expected.to be_contact_failed }

        context 'enters his last mind' do
          before { subject.process('some text') }

          it { is_expected.to be_tragic_end }

          it { is_expected.to be_completed }
        end
      end

      context 'and user selects email' do
        before { subject.process(User::EMAIL_OPTION) }

        shared_examples_for 'enter correct email first time' do
          before { subject.process('valera@gmail.com') }

          it { is_expected.to be_awaiting_contact_confirmation }

          context 'and user confirms his chooise' do
            before { subject.process(User::CONFIRM_YES) }

            it { is_expected.to be_happy_end }

            it { is_expected.to be_completed }
          end
        end

        it { is_expected.to be_awaiting_email }

        context 'and user enters his email' do
          context 'and email was correct' do
            it_behaves_like 'enter correct email first time'
          end

          context 'and user selects that email is wrong' do
            before do
              subject.process('valera@gmail.com')
              subject.process(User::CONFIRM_WRONG_EMAIL)
            end

            it { is_expected.to be_awaiting_email }

            it_behaves_like 'enter correct email first time'
          end
        end
      end

      context 'and user selects phone' do
        before { subject.process(User::PHONE_OPTION) }

        it { is_expected.to be_awaiting_phone }

        context 'and user enters phone' do
          before { subject.process('80966578567') }

          it { is_expected.to be_awaiting_contact_time }

          context 'and user provides contact time' do
            before { subject.process(User::CONTACT_TIME_OPTIONS.sample) }

            it { is_expected.to be_awaiting_contact_confirmation }

            context 'and user confirms correct phone' do
              before { subject.process(User::CONFIRM_YES) }

              it { is_expected.to be_happy_end }
            end

            context 'and user said that phone is wrong' do
              before { subject.process(User::CONFIRM_WRONG_PHONE) }

              it { is_expected.to be_awaiting_phone }
            end
          end
        end
      end
    end
  end
end
