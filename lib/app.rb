require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
require 'date'
puts "Today's date: #{Date.today}"

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
products_hash["items"].each do |item|
	puts "\n**************\n"
	# Print the name of the toy
	name = item["title"]
	puts "Name: #{name}"
  # Print the retail price of the toy
	retail_price = Float(item["full-price"])
	puts "Retail Price: #{retail_price}"
  # Calculate and print the total number of purchases
	num_purchases = item["purchases"].length
	puts "Total Purchases: #{num_purchases}"
  # Calculate and print the total amount of sales
	total_sales = 0
	item["purchases"].each do |purchase|
		total_sales += purchase["price"]
	end
	puts "Total Sales: #{total_sales}"
  # Calculate and print the average price the toy sold for
	avg_price = total_sales / num_purchases
	puts "Average Price: #{avg_price}"
  # Calculate and print the average discount (% or $) based off the average sales price
	avg_discount = (retail_price - avg_price) / retail_price * 100
	puts "Average Discount: #{avg_discount.round(2)}%"

end

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
#Got this next line from the forums. https://discussions.udacity.com/t/brand-section-help/47399/3
brands = products_hash["items"].map {|item| item["brand"]}.uniq

brands.each do |brand|
	puts "\n**************\n"
	# Print the name of the brand
	puts "Brand Name: #{brand}"
  # Count and print the number of the brand's toys we stock
	toys = products_hash["items"].select {|item| item["brand"] == brand}
	num_toys = 0
	toys.each {|toy| num_toys += toy["stock"]}
	puts "Number of Toys: #{num_toys}"
  # Calculate and print the average price of the brand's toys
	total_prod_price = 0
	toys.each {|toy| total_prod_price += Float(toy["full-price"])}
	avg_price = total_prod_price / toys.length
	puts "Average Product Price: #{avg_price.round(2)}"
  # Calculate and print the total revenue of all the brand's toy sales combined
	total_revenue = 0
	toys.each do |toy|
		toy["purchases"].each {|purchase| total_revenue += Float(purchase["price"])}
	end
	puts "Total Revenue: #{total_revenue.round(2)}"

end
