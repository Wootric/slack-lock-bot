class Lock < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :user_id

  after_create :create_lock_stat!
  after_destroy :create_unlock_stat!

  def create_lock_stat!
    create_stat!(:lock)
  end

  def create_unlock_stat!
    create_stat!(:unlock)
  end

  def create_stat!(command)
    ::Stat.create!(name: name, user_id: user_id, command: command)
  end
end
