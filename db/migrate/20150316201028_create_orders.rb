class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string      :order_no
      t.references  :customer
      t.float       :total
      t.date        :date
    end
  end

  def self.down
    drop_table :orders
  end
end
