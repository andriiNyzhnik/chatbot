class Question < ActiveRecord::Base
  belongs_to :conversation

  validates_presence_of :conversation
end
