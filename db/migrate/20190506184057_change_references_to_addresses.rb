class ChangeReferencesToAddresses < ActiveRecord::Migration[5.2]
  def up
    change_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.remove :address_type
    end
  end

  def down
    change_table :addresses do |t|
      t.remove_references :addressable, polymorphic: true
      t.add :address_type, :integer, default: 0
    end
  end
end
