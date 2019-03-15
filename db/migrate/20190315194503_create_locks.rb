class CreateLocks < ActiveRecord::Migration[5.2]
  def change
    create_table :locks do |t|
      t.string :name
      t.string :user_id
    end

    add_index :locks, :name, unique: true
  end
end
