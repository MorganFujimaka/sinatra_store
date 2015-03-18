Customer.where(firstname: "Morgan", lastname: "Fujimaka", email: "mo@fu.com", password: "12345678").first_or_create
Customer.where(firstname: "Hiroshi", lastname: "Ikeda", email: "hi@ik.com", password: "12345678").first_or_create
Product.where(name: "Apple", price: 15.5, status: 1, description: "The Red Delicious is a clone of apple cultigen, no...").first_or_create
Product.where(name: "Grape", price: 19.5, status: 1, description: "White grape").first_or_create