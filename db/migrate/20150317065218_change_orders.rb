class ChangeOrders < ActiveRecord::Migration
  def self.up
    add_timestamps :orders
    remove_column :orders, :date
  end

  def self.down
    remove_timestamps :orders
  end
end
