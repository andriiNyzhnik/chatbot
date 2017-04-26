shared_context 'common state behaviour' do
  let(:user) { create :user }
  let(:conversation) { create :conversation, users: [user] }

  it 'stores user answer' do
    expect{
      subject.process(user_input)
    }.to change { conversation.answers.where(body: user_input, user: user).count }.by(1)
  end
end
