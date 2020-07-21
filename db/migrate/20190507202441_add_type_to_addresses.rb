class AddTypeToAddresses < ActiveRecord::Migration[5.2]
  def up
    change_table :addresses do |t|
      t.column :type, :string
    end
  end

  def down
    change_table :addresses do |t|
      t.remove :type
    end
  end
end
