class Conversation < ActiveRecord::Base
  has_many :answers
  has_many :messages
  has_many :users, through: :answers

  def user
    users.first
  end
end
