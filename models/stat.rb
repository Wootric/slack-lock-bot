class Stat < ActiveRecord::Base
  validates_presence_of :user_id
  validates :command, presence: true, inclusion: { in: %w(list lock unlock) }
end
