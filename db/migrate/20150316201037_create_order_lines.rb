class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.references  :order
      t.references  :product
      t.integer     :qty
      t.float       :unit_price
      t.float       :total_price
    end
  end

  def self.down
    drop_table :order_lines
  end
end
