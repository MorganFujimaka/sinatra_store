class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string  :name
      t.float   :price, scale: 1
      t.integer :status
      t.string  :description
    end
  end

  def self.down
    drop_table :products
  end
end
