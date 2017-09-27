# Name: Brandon Siebert
# Course: CSC 415
# Semester: Fall 2017
# Instructor: Dr. Pulimood
# Project name: Assignment 1
# Description: Design a Set class which holds operates on a set of Subscriber objects.
# Filename: Quick_Demo.rb
# Description: Linear demo showing off the functionality of the classes contained in Subscriber_Set.rb
# Last modified on: 9/26/2018

require_relative "Subscriber_Set.rb"

puts "Reading in 15.csv..."
my_test = Set.new("15.csv")
puts "Done!"
puts "Reading in 15_alternate.csv"
my_test_alt = Set.new("15_alternate.csv")
puts "Done!"
puts "Reading in 10000.csv..."
my_test2 = Set.new("10000.csv")
puts "Done!"
puts "Reading in 750000.csv..."
my_test3 = Set.new("750000.csv")
puts "Done!\n"
my_subscriber = Subscriber.new(123123, "BRANDON")

# Here are a few unit tests for the Set functions

puts "Hello! This is a demonstration for the new Set and Subscriber classes. Below are a few examples."
puts "My custom subscriber: #{my_subscriber.to_s}"
puts "Result of loading in 15.csv: \n#{my_test.to_s}"
puts "And this is the number of duplicates rejected: #{my_test.dup_count}"
puts "For 10000.csv, this is how many subscribers it holds: #{my_test2.count}"
puts "And this is the number of duplicates rejected: #{my_test2.dup_count}"
puts "For 750000.csv, this is how many subscribers it holds: #{my_test3.count}"
puts "And this is the number of duplicates rejected: #{my_test3.dup_count}"
puts "15.csv unioned with 15_alternate.csv: \n" + Set.union(my_test, my_test_alt).to_s
puts "15.csv intersected with 15_alternate.csv: " + Set.intersect(my_test, my_test_alt).to_s
pair_results = Set.cartesian_product(my_test, my_test_alt)
print "Would you like to print the results of a cartesian product operation? (yes/no): "
is_printing_result = gets.chomp
if (is_printing_result == 'yes')
	puts "Result of 15.csv cartesian product: \n" + Set.print_pairs(pair_results)
elsif (is_printing_result == 'no')
	# Finish
else
	puts "Invalid Option. Exiting"
end
puts "Demo has finished"
