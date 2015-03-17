class Product < ActiveRecord::Base
  has_many :order_lines

  validates :name, :price, :status, :description, presence: true
  validates :price, :status, numericality: true
  validates_inclusion_of :status, in: [1, 2]
end

class Customer < ActiveRecord::Base
  has_many :orders

  validates :firstname, :lastname, :email, :password, presence: true
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_length_of :password, minimum: 7
end

class Order < ActiveRecord::Base
  has_many :order_lines
  belongs_to :customer
end

class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
end