class Answer < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :conversation
end
