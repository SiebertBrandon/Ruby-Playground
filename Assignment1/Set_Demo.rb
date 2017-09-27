# Name: Brandon Siebert
# Course: CSC 415
# Semester: Fall 2017
# Instructor: Dr. Pulimood
# Project name: Assignment 1
# Description: Design a Set class which holds operates on a set of Subscriber objects.
# Filename: Set_Demo.rb
# Description: Houses the Set and Subscriber classes used for Assignment 1
# Last modified on: 9/26/2018

require_relative "Subscriber_Set.rb"

# String Constants
welcome_message = "Welcome to the Set_Subscriber.rb demo. You will be presented with a set of \ncommands used to run and test all functionality of this module. \nPlease ensure your dataset files are properly formatted: \nRow:(<account_number> <whitespace> <name>)."
option0 = "[1]: Create a new Set"
option1 = "[2]: Load dataset from file."
option2 = "[3]: Print loaded dataset."
option3 = "[4]: Add a new Subscriber to a dataset."
option4 = "[5]: Check if a dataset is empty."
option5 = "[6]: Find the union between two datasets."
option6 = "[7]: Find the intersection between two datasets."
option7 = "[8]: Find the Cartesian Product between two datasets."
option8 = "[9][Q][q]: Quit"
# String Constants End

puts welcome_message

loaded_datasets = Array.new(0)

while true
	puts ' '
	puts '/`--------------------- Main Menu ---------------------`\\'
	puts '| ' + option0 + '					|'
	puts '| ' + option1 + '				|' 
	puts '| ' + option2 + '				|'
	puts '| ' + option3 + '		|'
	puts '| ' + option4 + '			|' 
	puts '| ' + option5 + '		|'
	puts '| ' + option6 + '      |'
	puts '| ' + option7 + ' |'
	puts '| ' + option8 + '					|'
	puts '|,-----------------------------------------------------,|'
	puts '\\.-----------------------------------------------------./'
	puts ' '
	print 'Please choose which command to execute: '
	menu_choice = gets.chomp
	puts ''
	case 
	when menu_choice == "1" || menu_choice == "[1]"
		puts 'Executing ' + option0
		loaded_datasets.push([Set.new, "NewSet"])
		puts 'Created a new Set!'
	when menu_choice == "2" || menu_choice == "[2]"
		puts 'Executing ' + option1
		print '[1] Please enter a file url to load from: '
		filename = gets.chomp
		puts ''
		if !filename.nil?
                	loaded_datasets.push([Set.new(filename), filename])
			puts "Successfully loaded " + filename + "!"
                else
			puts 'Invalid File Name!'
		end
	when menu_choice == "3" || menu_choice == "[3]"
		puts 'Executing ' + option2
		if loaded_datasets.count == 0
			puts '<No Datasets Loaded>'
			puts 'Returning to the Main Menu...'
			next
		else
			index = 1
			puts '-List of loaded datasets-'
			loaded_datasets.each do |set, name|
				puts '[' + index.to_s + ']: ' + name
				index += 1
			end
			puts ''
		end
		while true
			print 'Select the number of a loaded dataset to print (Enter [Q] or [q] to return to the Main Menu): '
			menu_2_choice = gets.chomp
			case 
			when menu_2_choice == "Q" || menu_2_choice == "[Q]" || menu_2_choice == "q" || menu_2_choice == "[q]"
				puts 'Returning...'
				break
			else
				index_choice = menu_2_choice.to_i
				if (index_choice != 0)
					case
					when index_choice < index
						printing_set = loaded_datasets[index_choice - 1]
						puts 'Printing Set: ' + printing_set[1]
						puts printing_set[0].to_s
						puts ''
					else
						puts 'Invalid dataset number!'
					end
				else
					puts 'Invalid input!'
				end
			end
		end
	when menu_choice == "4" || menu_choice == "[4]"
		puts 'Executing ' + option3
	
	when menu_choice == "5" || menu_choice == "[5]"
		puts 'Executing ' + option4
	
	when menu_choice == "6" || menu_choice == "[6]"
		puts 'Executing ' + option5
	
	when menu_choice == "7" || menu_choice == "[7]"
		puts 'Executing ' + option6
	
	when menu_choice == "8" || menu_choice == "[8]"
		puts 'Executing ' + option7
	
	when menu_choice == '9' || menu_choice == '[9]' || menu_choice == 'Q' || menu_choice == '[Q]' || menu_choice == 'q' || menu_choice == '[q]'
		puts "Thank you for trying out this demo!"
		break
	else
		puts "#{menu_choice} is not a valid command. Please refer to the prompt and enter the number corresponding to a valid command."
	end
end
puts "Exiting..."
